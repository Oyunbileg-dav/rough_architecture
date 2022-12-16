## 3-tier application deployment on AWS using Terraform and Docker
In this blog post, we will build a highly available application on top of AWS cloud services. 
To make the infrastructure configurations more illustrative, let's imagine a scenario where CLOUD is very much needed!

### Scenario description
We will design an architecture for a vocational training web application, where learners will be able to take courses in the form of pre-recorded videos. This web app is intended to solve the problem of people in rural areas who want to take vocational training courses but cannot due to the over-centralization of training centers in the capital city of Mongolia. 
#### Requirements:
- High availability is needed as there should be no interruption when the learner is watching pre-recorded lessons
- The server should always be up to enable users to access courses anytime
- It must be easy to scale up or down because we do not know the traffic load yet
- The app servers that deal with the database should not be accessible by the rest of the world to ensure security (Intellectual property, user data security)
- There should be no single point of failure (especially when uploading videos from the course provider interface)

By the end of this tutorial, we will have the following architecture deployed.

![Diagram](/images/diagram.png)

1. Login to ECR: replace region and AWS account ID. If you don't know where to find your account ID, please refer to this page. 
```
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
```
2. Create ECR repositories: replace ecr_application_repo_name. This cmd line describes an ecr repository if it exists. Otherwise, it creates a new repository with the name specified.
```
ECR_APPLICATION_REPO_NAME=app-application-tier
aws ecr describe-repositories --repository-names ${ECR_APPLICATION_REPO_NAME} || aws ecr create-repository --repository-name ${ECR_APPLICATION_REPO_NAME}
```
Then, we will do the same for the presentation tier. 
```
ECR_PRESENTATION_REPO_NAME=app-presentation-tier
aws ecr describe-repositories --repository-names ${ECR_PRESENTATION_REPO_NAME} || aws ecr create-repository --repository-name ${ECR_PRESENTATION_REPO_NAME}
```
3. Build and push the images for each tier: replace ecr_application_repo_name with the one you specified earlier. 
```
cd ./application-tier/
ECR_APPLICATION_TIER_REPO=$(aws ecr describe-repositories --repository-names ${ECR_APPLICATION_REPO_NAME} | jq -r '.repositories[0].repositoryUri')
docker build -t app-application-tier .
docker tag app-application-tier:latest $ECR_APPLICATION_TIER_REPO:latest
docker push $ECR_APPLICATION_TIER_REPO:latest
```
Then, let's do the same for the presentation tier. 
```
cd ../presentation-tier/
ECR_PRESENTATION_TIER_REPO=$(aws ecr describe-repositories --repository-names ${ECR_PRESENTATION_REPO_NAME} | jq -r '.repositories[0].repositoryUri')
docker build -t app-presentation-tier .
docker tag app-presentation-tier:latest $ECR_PRESENTATION_TIER_REPO:latest
docker push $ECR_PRESENTATION_TIER_REPO:latest
```

Now, we should navigate to the Terraform folder and run `terraform init`.

We should run `terraform apply`, and type yes to approve the changes. It might take a while since we are provisioning a couple of resources. If everything goes as planned, you will get the DNS url for the front-facing load balancer.
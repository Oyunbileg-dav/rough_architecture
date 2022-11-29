import express from 'express';
import fetch from 'node-fetch';

const PORT = process.env.PORT || 3000

let app = express()

app.get('/', async (req, res) => {
  fetch('http://').then(async(response) => {
    const hostname = await response.text();
    res.send(`Hello from ${hostname}`)
  })
})

// Custom 404 route not found handler
app.use((req, res) => {
    res.status(404).send('404 not found')
  })

app.listen(PORT, () => {
    console.log(`Listening on PORT ${PORT}`);
  })
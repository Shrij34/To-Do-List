const express = require('express');
const path = require('path');

const app = express();
const port = 3000;


// Serve static files (CSS, JS, Images) from the project directory
app.use(express.static(path.join(__dirname)));


// Fallback route for loading index.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

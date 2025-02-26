Step 1: Install Node.js& npm
First, ensure you have Node.jsand npm installed.

Download & Install Node.js(LTS version recommended).

Verify Installation by running:

sh
node -v
npm -v
If both commands return version numbers, you're good to go.

Step 2: Initialize npm in Your Project
Navigate to your To-Do List project folder:

sh
cd D:\Az400\shubam\Projects\To-Do-List
npm init -y
This creates a package.json file, which manages dependencies.

Since you only have a script.js file and not an index.js, you can either:

Option 1: Change main to script.js(Recommended)
When you run npm init -y, it creates a package.json file with this line:

json
"main": "index.js",
Since your project does not have index.js, you should change it to:

json
"main": "script.js",
Step 3: Install Live Server (For Auto-Refresh)
Since this is a frontend-only project, Live Server will help with automatic reloading.

Install Live Server globally:

sh
npm install -g live-server
Start the project:

sh
live-server
This will open index.html in your default browser and reload automatically when you make changes.

Step 4: Install Additional Frontend Dependencies (Optional)
If your script.js uses libraries like Bootstrap or jQuery, install them using npm:

jQuery
sh
npm install jquery
Bootstrap
sh
npm install bootstrap
ESLint (for JavaScript Code Quality)
sh
npm install eslint --save-dev
npx eslint --init
Need to install the following packages:

@eslint/create-config@1.5.0
Ok to proceed? (y) press y
How would you like to use ESLint?", you should choose:

✅ "To check syntax and find problems"

Since your project is a frontend-only JavaScript project (without Node.jsmodules), you should choose:

✅ "None of these"

Since your project is a plain JavaScript (Vanilla JS) frontend project, you should choose:

✅ "None of these"

Since your project is a JavaScript project and not using TypeScript, you should select:

✅ "No"

? Where does your code run? ... (Press <space> to select, <a> to toggle all, <i> to invert selection)

✅ "Browser"

Step 5: Project Folder Structure
Your final folder structure should look like this:

To-Do-List/
│── css/                 (Stylesheets)
│── img/                 (Images)
│── js/                  (JavaScript files)
│   └── script.js        (Main script)
│── screenshots/         (Screenshots)
│── index.html           (Main HTML file)
│── README.md            (Project documentation)
│── readme.txt           (Text file)
│── package.json         (npm package file)
│── node_modules/        (Installed dependencies)
Step 6: Running the Project
Now, open your terminal in the project folder and run:

sh
live-server --port=9000
Your browser will automatically open and display your To-Do List app.

Dockerizing the Container
First, Initialize Docker
sh
docker init
? What application platform does your project use? Node

? What version of Node do you want to use? (22.12.0)

? What command do you want to use to start the app? [tab for suggestions] (node script.js)

Install Express
Add Express to your package.json:

sh
npm install express
Create a Simple Express Server
Create a file server.js (or update your script.js for this logic):

js
const express = require('express');
const path = require('path');

const app = express();
const port = 3000;

// Serve static files from the 'js' directory
app.use(express.static(path.join(__dirname, 'js')));

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
Update Dockerfile
Modify your Dockerfile to run the Express server instead of script.js:

dockerfile
CMD ["node", "server.js"]
Docker Compose Configuration
Create docker-compose.yaml:

yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"  # Expose port 3000 on the host and map it to the container's port 3000
    volumes:
      - ./localstorage:/usr/src/app/localstorage  # Mount the project directory to /usr/src/app in the container
    environment:
      - NODE_ENV=production
    command: ["node", "server.js"]  # This is optional if it's already set in the Dockerfile
If you encounter issues:

Update server.js to remove js:

js
// Serve static files (CSS, JS, Images) from the project directory
app.use(express.static(path.join(__dirname)));
Modify the COPY . . line in Dockerfile:

dockerfile
COPY . /usr/src/app
WORKDIR /usr/src/app
Use Docker Volumes for Persistent Data
If localStorage data needs to persist across container restarts, you might need to mount a volume to store localStorage data outside the container. This allows the data to survive restarts and ensures appropriate access and permissions.

Example in docker-compose.yml:
yaml
volumes:
  - ./localstorage:/usr/src/app/localstorage
If issues persist, ensure correct ownership and permissions:

dockerfile
# Temporarily switch to root to change ownership
USER root

# Change the ownership of the app directory to the node user
RUN chown -R node:node /usr/src/app

# Switch back to non-root user
USER node

ENV NODE_ENV=production
Build and Run Docker Compose
sh
docker-compose up --build
To restart with fresh build:
sh
docker-compose down && docker-compose up --build -d
Command History
sh
  103  docker-compose build
  104  docker-compose build
  105  docker-compose up
  106  docker ps -a
  107  docker ps -a
  108  docker ps -a
  109  docker ps -a
  110  docker exec it aaa23eb9eb96 bash
  111  docker start aaa23eb9eb96
  112  docker ps
  113  docker exec it

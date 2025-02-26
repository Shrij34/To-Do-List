# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG NODE_VERSION=22.12.0

FROM node:${NODE_VERSION}-alpine


# Set the production environment
ENV NODE_ENV=production


# Set working directory
WORKDIR /usr/src/app

# Copy package files first to leverage Docker's layer caching
COPY package.json package-lock.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Temporarily switch to root to change ownership
USER root

# Change the ownership of the app directory to the node user
RUN chown -R node:node /usr/src/app

# Run the application as a non-root user.
USER node

# Ensure that the node user has read/write permissions
RUN chmod -R 755 /usr/src/app

# Copy the rest of the source files into the image.
COPY . /usr/src/app

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD ["node", "server.js"]


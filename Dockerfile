FROM node:20-alpine

# Install dependencies for building
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

RUN npm ci --production=false

# Copy the rest of the app
COPY . .

# Build the app (adjust if your repo has a build step; many use npm run build)
RUN npm run build || echo "No build script, skipping..."

# Expose the port
EXPOSE 8080

# Start command - adjust if your start script is different (check package.json)
CMD ["npm", "start"]

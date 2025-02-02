# Stage 1: Build the React App
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json first to cache dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the project
COPY . .

# Run the build process
RUN npm run build

# Ensure the build folder is created
RUN ls -l /app/build || echo "Build folder not found!"

# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine

# Ensure build directory exists
RUN mkdir -p /usr/share/nginx/html

# Copy built files from the first stage
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

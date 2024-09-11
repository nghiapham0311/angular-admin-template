# Stage 1: Build Angular app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built Angular app from the 'build' stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom Nginx config if needed (optional)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

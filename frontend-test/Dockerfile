# Build stage
FROM node:20-alpine as build

# Install build dependencies
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Copy frontend-react package files and install there
COPY frontend-react/package.json frontend-react/package-lock.json* ./frontend-react/
WORKDIR /app/frontend-react

# Clean install with all optional dependencies
RUN rm -rf node_modules package-lock.json && npm install --include=optional --legacy-peer-deps

# Copy frontend source code
COPY frontend-react/. ./

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built assets from build stage
COPY --from=build /app/frontend-react/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

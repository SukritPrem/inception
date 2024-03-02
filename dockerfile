# Use the official Nginx image as the base image
FROM nginx

# Copy your Nginx configuration file from the host to the container
COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /usr/share/nginx/html/index.html

# Expose the port(s) Nginx will be listening on
EXPOSE 80

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
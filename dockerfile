# Use the official Nginx image as the base image
FROM nginx

# Install OpenSSL package
RUN apt-get update && \
    apt-get install -y openssl


# Copy your Nginx configuration file from the host to the container
COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /val/www/

# Expose the port(s) Nginx will be listening on
EXPOSE 443

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
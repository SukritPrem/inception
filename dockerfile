# Use the official Nginx image as the base image
FROM nginx

# Install OpenSSL package
RUN apt-get update && \
    apt-get install -y openssl

# Set the working directory
WORKDIR .

# Generate self-signed SSL certificate and private key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/certs/certificate.key -out /etc/ssl/certs/certificate.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Copy the generated SSL certificate and private key to Nginx directory
RUN cp /etc/ssl/certs/certificate.crt  /etc/nginx/ssl.crt && \
    cp /etc/ssl/certs/certificate.key /etc/nginx/ssl.key

# Copy your Nginx configuration file from the host to the container
COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /val/www/

# Expose the port(s) Nginx will be listening on
EXPOSE 443

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
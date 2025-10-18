FROM amazonlinux:latest

# Install dependencies and clean up in a single layer
RUN dnf update -y && \
    dnf install -y httpd wget unzip && \
    dnf clean all

# Set working directory to web root
WORKDIR /var/www/html

# Download, extract, and deploy web files in a single layer
RUN wget https://github.com/azeezsalu/techmax/archive/refs/heads/main.zip && \
    unzip main.zip && \
    cp -r techmax-main/* /var/www/html/ && \
    rm -rf techmax-main main.zip


# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
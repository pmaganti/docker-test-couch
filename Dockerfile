
FROM ubuntu

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY build.sh /usr/src/app/
CMD ["/usr/src/app/build.sh"]
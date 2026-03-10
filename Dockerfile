# Use the minimal Alpine Linux base image
# The Alpine Linux image is chosen for its small size and simplicity.
# You can use other base images (e.g., Debian, Ubuntu, Fedora) depending on your needs.
FROM alpine

# Installs the GCC compiler and essential build tools
RUN apk add --no-cache build-base=0.5-r3

# Sets the working directory inside the container
WORKDIR /app

# Copies the source code into the container
COPY montecarlopi.c .

# Compiles the source code inside the container
RUN gcc montecarlopi.c -o montecarlopi

# Specifies the default command to run the application when the container starts
ENTRYPOINT ["/app/montecarlopi"]
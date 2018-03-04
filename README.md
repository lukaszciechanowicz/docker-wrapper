# dockerwrapper
A simple bash wrapper for Docker client that generates own Docker image names

# Docker container names

The operator can identify a container in three ways:

Identifier type	 | Example value
--- | ---
UUID long identifier | “f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778”
UUID short identifier| “f78375b1c487”
Name | “evil_ptolemy”

The UUID identifiers come from the Docker daemon. If you do not assign a container name with the --name option, then the daemon generates a random string name for you. Defining a name can be a handy way to add meaning to a container. If you specify a name, you can use it when referencing the container within a Docker network. This works for both background and foreground Docker containers.

# How does Docker do that?

Over 90% of the Docker code is written in Go, and they Markup : [use it to generate names](https://github.com/moby/moby/blob/master/pkg/namesgenerator/names-generator.go).

BTW: There is a cool Docker name generator as a service available online: https://frightanic.com/goodies_content/docker-names.php
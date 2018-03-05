# dockerwrapper
A super simple Bash wrapper for Docker client that generates your own container names.
It injects its own randomly generated names each time you don't pass *--name* attribute to *docker run* command.

Examples:

You can use dockerwrapper to name your containers with names of your team mates

![example01](screenshots/example01.png?raw=true "example01")

or even make Docker speak your language a bit

![example02](screenshots/example02.png?raw=true "example02 - Polish version")
# Docker container names

The operator can identify a Docker container in three ways:

Identifier type	 | Example value
--- | ---
UUID long identifier | “f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778”
UUID short identifier| “f78375b1c487”
Name | “evil_ptolemy”

The UUID identifiers come from the Docker daemon. If you do not assign a container name with the --name option, then the daemon generates a random string name for you.
Defining a name can be a handy way to add meaning to a container. If you specify a name, you can use it when referencing the container within a Docker network.

This works for both background and foreground Docker containers.

# How does Docker do that?

Over 90% of the Docker code is written in Go, and they [use it to generate names](https://github.com/moby/moby/blob/master/pkg/namesgenerator/names-generator.go).

BTW: There is a cool Docker name generator as a service available online: https://frightanic.com/goodies_content/docker-names.php

# Installation

It's super simple. Just download dockerwrapper script and set an alias.

```
mkdir $HOME/.dockerwrapper
wget https://github.com/lukaszciechanowicz/dockerwrapper/blob/master/dockerwrapper.sh -P $HOME/.dockerwrapper
chmod +x $HOME/.dockerwrapper/dockerwrapper.sh
alias docker="$HOME/.dockerwrapper/dockerwrapper.sh"
```
To make if work after you reopen your terminal, add an alias to your *.bash_profile* / *.zshrc* file

```
alias docker="$HOME/.dockerwrapper/dockerwrapper.sh"
```


# `go-openssl-shim`
> A tiny sample application to run go-openssl-shim across multiple distros.

## Usage
It can be either run with a docker container or directly from an debian based distribution.  It supports following docker containers:
 - `alpine`
 - `jessie`
 - `stretch`
 - `trusty`
 - `xenial`

### Docker

```bash
    # build docker image of particular distro
    $ make build DISTRO=jessie # it could be anything
    # run the hello world
    $ make run DISTRO=jessie
```

### Vanilla

To run it without docker, you must have a working golang compiler installed with all its environment variable setup. 

```bash
    # clone this repository in your $GOPATH
    # setup your system
    $ ./scripts/setup.sh
    # export required environment variables
    $ source srcipts/env.sh
    # run the hello world program
    $ go run main.go
```
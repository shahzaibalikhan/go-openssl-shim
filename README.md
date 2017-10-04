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
    $ sudo ./scripts/setup.sh
    # export required environment variables
    $ source srcipts/env.sh
    # run the hello world program
    $ go run main.go
```

### Note
OpenSSL has a method called `FIPS_mode_set()` that we invoke before execution to enter FIPS mode of operation, if the FIPS Object Module successfully enters FIPS mode, the function will return that non-zero value and a power-up self-test is performed automatically with its call. These self-tests can also be optionally invoked at any time by the `FIPS_selftest()` call in `C` code.

Its being done in `openssl` package as follows:
```go
package openssl

// #cgo pkg-config: openssl
// #cgo LDFLAGS: -lcrypto -ldl
// #cgo CFLAGS: -std=c99
// #include <openssl/err.h>
// #include <openssl/crypto.h>
// #include <stdlib.h>
// extern int FIPS_init(void);
// extern void schedule_thread_cleanup(void);
import "C"
import (
	"log"
	"runtime"
	"strings"
)

func init() {
	runtime.LockOSThread()
	defer runtime.UnlockOSThread()
	if C.FIPS_init() != 1 {
		log.Fatal(GetError())
	}
}
```
Here `C.FIPS_init()` is a function that wraps over OpenSSL's `FIPS_mode_set()` which is being called in `init` function, so whenever `openssl` package is included anywhere, it automatically initiates the FIPS mode thus resulting in running all the self-tests.  

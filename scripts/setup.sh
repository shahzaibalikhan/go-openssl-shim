#! /bin/bash

## this script is to setup hello-world application on debian based distros.

if [ "$EUID" -ne 0 ]
  then echo "please run as root."
  exit 1
fi

if [ -z "$(command -v openssl)" ]
    then echo "openssl is already installed, removing it..." && apt-get remove --purge openssl
fi

if [ -z "$(command -v go)" ]
    then echo "go is required, aborting..."; exit 1
fi

pushd . &&
cd vendor/openssl-fips-2.0.14 &&
./config &&
make &&
make install &&
popd &&
pushd . &&
cd vendor/openssl-1.0.2k &&
./config fips &&
make depend &&
make &&
make install &&
popd &&
pushd . &&
cd vendor &&
ln -s openssl-fips-2.0.14/go/openssl . &&
popd &&
echo "system setup successfully, please execute source ./env.sh to export required environment variables."

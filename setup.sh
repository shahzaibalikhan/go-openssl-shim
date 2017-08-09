pushd . && cd vendor/openssl-fips-2.0.14 && ./config && make && make install && popd &&
pushd . && cd vendor/openssl-1.0.2k && ./config fips && make depend && make && make install && popd &&
pushd . && cd vendor && ln -s openssl-fips-2.0.14/go/openssl . && popd

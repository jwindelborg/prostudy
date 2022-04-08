#!/usr/bin/env bash

if [[ "$1" == "-c" ]]; then
    rm InRelease
    rm Release
    rm Release.gpg
    rm Packages
    rm Packages.gz
    exit 0;
fi

if [[ "$1" == "-f" ]]; then
    rm InRelease
    rm Release
    rm Release.gpg
    rm Packages
    rm Packages.gz
fi

if [[ "$1" == "--sign" ]]; then
    dpkg-sig -k A2A63A65198D89BCED4476CED6E85EDB1570ED3E --sign builder $2
    exit 0;
fi

dpkg-scanpackages . /dev/null > Packages
gzip --keep --force -9 Packages

echo -e "Date: `LANG=C date -Ru`" >> Release
echo -e 'MD5Sum:' >> Release
printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
echo -e '\nSHA256:' >> Release
printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release

gpg --default-key A2A63A65198D89BCED4476CED6E85EDB1570ED3E --clearsign --digest-algo SHA512 -o InRelease Release
gpg --default-key A2A63A65198D89BCED4476CED6E85EDB1570ED3E -abs --digest-algo SHA512 -o Release.gpg Release

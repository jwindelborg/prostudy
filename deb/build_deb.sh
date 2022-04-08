#!/usr/bin/env bash

VERSION=$(sed -n 2p deb/control | awk '{ print $2 }')

mkdir -p prostudy_$VERSION
mkdir -p prostudy_$VERSION/DEBIAN
mkdir -p prostudy_$VERSION/usr/local/bin
mkdir -p prostudy_$VERSION/usr/local/share/prostudy
mkdir -p prostudy_$VERSION/usr/share/bash-completion/completions
mkdir -p prostudy_$VERSION/usr/share/zsh/vendor-completions
mkdir -p prostudy_$VERSION/usr/share/man/man8

cp deb/control prostudy_$VERSION/DEBIAN/
cp prostudy prostudy_$VERSION/usr/local/bin/
cp example/* prostudy_$VERSION/usr/local/share/prostudy/
cp completions/bash/prostudy prostudy_$VERSION/usr/share/bash-completion/
cp completions/zsh/_prostudy prostudy_$VERSION/usr/share/zsh/vendor-completions/

cp man/prostudy prostudy_$VERSION/usr/share/man/man8/
gzip prostudy_$VERSION/usr/share/man/man8/prostudy
mv prostudy_$VERSION/usr/share/man/man8/prostudy.gz prostudy_$VERSION/usr/share/man/man8/prostudy.8.gz

dpkg-deb --build prostudy_$VERSION

#dpkg -c prostudy_$VERSION.deb

rm -rf prostudy_$VERSION/

#!/usr/bin/env bash

echo "Simple changelog" > changelog
echo "" >> changelog
git --no-pager log --format=fuller >> changelog
echo "" >> changelog
echo "Full signed changelog" >> changelog
echo "" >> changelog
git --no-pager log --format=raw >> changelog

gzip -9 -n changelog
gzip -9 -n man/prostudy.8

mkdir -p bin/usr/bin/
mkdir -p bin/usr/share/bash-completion/completions/
mkdir -p bin/usr/share/zsh/vendor-completions/
mkdir -p bin/usr/share/doc/prostudy/
mkdir -p bin/usr/share/man/man8/
mkdir -p bin/usr/share/prostudy/
mkdir -p bin/DEBIAN/

cp prostudy bin/usr/bin/prostudy
cp completions/bash/prostudy bin/usr/share/bash-completion/completions/prostudy
cp completions/zsh/_prostudy bin/usr/share/zsh/vendor-completions/_prostudy
cp LICENSE bin/usr/share/doc/prostudy/copyright
mv changelog.gz bin/usr/share/doc/prostudy/changelog.gz
cp man/prostudy.8.gz bin/usr/share/man/man8/prostudy.8.gz
cp example/block.txt bin/usr/share/prostudy/block.txt
cp example/ipblock.txt bin/usr/share/prostudy/ipblock.txt
cp example/pblock.txt bin/usr/share/prostudy/pblock.txt
cp example/post.sh bin/usr/share/prostudy/post.sh

cat >bin/DEBIAN/control <<EOF
Package: prostudy
Version: 0.1-1
Maintainer: Julie Windelborg Nielsen <julie@windelborg.dk>
Section: admin
Architecture: all
Priority: optional
Depends: whiptail, iptables, libnotify-bin
Recommends: figlet
Description: Pro Study
 For blocking distractions while studying.
 Very experimential
 (be warned!)
EOF

gunzip man/prostudy.8.gz

mv bin prostudy_0.1-1

dpkg-deb --build --root-owner-group prostudy_0.1-1

#dpkg-sig --sign builder prostudy_1.1-1.deb /// We don't have permissions in fakeroot
dpkg-sig -k A2A63A65198D89BCED4476CED6E85EDB1570ED3E --sign builder prostudy_0.1-1.deb

rm -r prostudy_0.1-1/

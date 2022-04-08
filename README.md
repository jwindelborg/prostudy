# Pro Study

A study blocker for Linux

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The following requirements have to be met before you can use this software:

* Use Linux
* Be able to install the dependencies
* If some dependency can't be installed, modify the source to exclude it or use an alternative

### Installing

**Fast install script**

**_The debian repositories is no longer provided by me, only manual installation is currently supported_**

If you are on a debian system the fastest way to install the program is to run our short shell script.

For quick install on debian, type the following command in a terminal:

```
curl -sSL https://deb.windelborg.dk/prostudy_install | sudo bash
```

*It can also be installed slightly more manually by running these commands*

```
curl -sL "https://keybase.io/windelborg/pgp_keys.asc" | sudo apt-key add -
echo "deb http://deb.windelborg.dk /" | sudo tee /etc/apt/sources.list.d/windelborg.list
sudo apt-get update
sudo apt-get install prostudy
```

Afterwards the package will be managed with your normal repository manager.

**Manual install**

*If you are not on debian, or you just want to install it manually, installing is still easy:*

Start by cloning the repository to somewhere nice:

```
sudo git clone https://github.com/jwindelborg/prostudy /opt/
```

Then lets make the program actually executable.

```
sudo ln -s /opt/prostudy/prostudy /usr/bin/prostudy
```

To be able to automatically generate example configs they will need to be in the right location:

```
sudo mkdir -p /usr/share/prostudy
sudo cp /opt/prostudy/example/* /usr/share/prostudy/
```

If you want bash autocompletion all you have to do is this:

```
sudo ln -s /opt/prostudy/completions/bash/prostudy /usr/share/bash-completion/completions/prostudy
```

If you want zsh completions it's just as simple:

```
sudo ln -s /opt/prostudy/completions/zsh/_prostudy /usr/share/zsh/vendor-completions/_prostudy
```

And lastly if you want man pages:

```
sudo cp /opt/prostudy/man/prostudy.8.gz /usr/share/man/man8/
```

But obviously you can just clone the package and run the software directly.

## Dependencies

* [bash](https://www.gnu.org/software/bash/) - The Bourne-Again SHell
* [FIGlet](http://www.figlet.org/) - Nice ASCII art
* [Whiptail](https://pagure.io/newt) - For GUI
* [iptables](https://www.netfilter.org/projects/iptables/index.html) - Linux firewall
* [sudo](https://www.sudo.ws/) - *S*uper-*u*ser *do*
* [libnotify](https://packages.debian.org/source/stretch/libnotify) - For `notify-send` notifications
* [procps](https://gitlab.com/procps-ng/procps) - For things like `pgrep` and `pkill`

## Authors

* **Julie Windelborg Nielsen** - *Initial work* - [jwindelborg](https://github.com/jwindelborg)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

This project is inspired by similar software solutions such as [Cold Turkey](https://getcoldturkey.com/) and [Forest](https://www.forestapp.cc).

Vagrant LAMP - MongoDB
============
A simple Vagrant LAMP for development (Ubuntu 16.04 LTS (Xenial Xerus), Apache 2, PHP 7.3, MongoDB 4.2)

Prerequisites
-------------
- [VirtualBox](https://www.virtualbox.org/) - Free  and open-source tool for virtual machines.
- [Vagrant](https://www.vagrantup.com/) - Free and open-source tool that automates the creation of development environments within a virtual machine.

Usage
-----
- Clone this repository (if you already have a project, copy 'Vagrantfile' & 'vagrant.sh' files into your project folder)
- Run: `vagrant up`
- SSH to your vagrant web-server: `vagrant ssh`
- Move to your project directory inside vagrant: `cd /vagrant`
- Install PHP library using Composer: `composer require mongodb/mongodb`
- Your server is ready: `http://localhost:4000`

Enjoy!

# Uso de Vagrant

## Configuración


### 1 - Descargar imágen máquina virtual base

Este comando descarga la máquina del registro de vagrant:

```bash
	vagrant box add ubuntu/focal64
```

### 2 - Crear Vagrantfile con la base anterior

```bash
vagrant init ubuntu/focal64
```

### 3 - Arrancar máquina vagrant

```bash
vagrant up
```

La máquina virtual se crea en el directorio or defecto de VirtualBox.

### 4 - Parar máquina vagrant

```bash
vagrant halt
```

### 5 - Suspender máquina vagrant

```bash
vagrant suspend
```

### 6 - Destruir máquina vagrant

Destruye la máquina virtual de vagrant, que la guarda Virtual Box en el directorio ~/VirtualBox VMs.

```bash
vagrant destroy
```

### 7 - Actualizacion

Actualizar imagen

```bash
vagrant box update
```

## Conexión a máquina vagrant

### Conexión SSH

```bash
vagrant ssh
```

### Mostar parámetros conexión SSH

```bash
vagrant ssh-config
```

### Configurar máquina con Ansible

Añadir al fichero Vagrantfile:

```
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "kubuntu_2004_servidor.yml"
  end
```

# Setup Vagrant box (Ubuntu 14.04)

## Introduction

This file discribe all the steps in order to setup a Vagrant box (using the [Ansible Ubuntu simple Symfony App](https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony) config - please refer to this repository for more info).

## Requirements

* [Git](http://git-scm.com)
* [Virtual box](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com)
* [Ansible](http://www.ansible.com)

## Install the Vagrant box

### Create the box

```bash
$ cd ~/vagrant/vm1
$ vagrant box add {title} {url}
$ vagrant init {title}
```

Sample box: [Ubuntu Server Precise 12.04.4 amd64 (source) Kernel is ready for Docker (Docker not included) Contains Chef, Puppet](https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box)

For example:
```bash
$ cd ~/vagrant/vm1
$ vagrant box add ubuntu_14_04_basebox https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box
$ vagrant init ubuntu_14_04_basebox
```

### Config the VM

Add the following lines in your VagrantFile
```ruby
  config.vm.network "forwarded_port", guest: 20, host: 20020
  config.vm.network "forwarded_port", guest: 21, host: 20021
  config.vm.network "forwarded_port", guest: 22, host: 20022
  config.vm.network "forwarded_port", guest: 80, host: 20080
  for i in 1024..1048
    config.vm.network :forwarded_port, guest: i, host: i
  end
  config.vm.network "forwarded_port", guest: 3306, host: 23306
```

### Run the VM

```bash
$ vagrant up
```

## Ansible config


### Clone the Ansible config

Clone the [Ansible Ubuntu simple Symfony App](https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony).

```bash
$ cd ~/git
$ git clone https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony.git
$ cd remiii-ansible-ubuntu-app-simple-symfony
```

### Config the Ansible config

*** WARNING: is just a sample, please ie. [remiii-ansible-ubuntu-app-simple-symfony](https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony/blob/master/README.md#setup) ***

Setup the vars in `vars/myConfig.yml` and add `ansible_inventory_machinename` file: [More info here](https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony/blob/master/README.md#setup).

```
# ansible_inventory_machinename
machine ansible_ssh_host='127.0.0.1' ansible_ssh_port=20022
```

Copy the config dist file `vars/myConfig.yml.dist`
```sh
$ cp vars/myConfig.yml.dist vars/myConfig.yml
```

```
# pathToTheProject/vars/myConfig.yml
    ...
    rootPath: '~/git/remiii-ansible-ubuntu-app-simple-symfony'
    hostname: 'vm1.local'
    publicIpAddress: '127.0.0.1'
    ...
```

Add some files in the `vars` directory: [More info here](https://github.com/Remiii/remiii-ansible-ubuntu-app-simple-symfony/blob/master/README.md#setup).

- myGitUserMachineUserKey
- myGitUserMachineUserKey.pub
- mySSHPublicKey.pub
- ...

### Run the Ansible config

Exec the config:
```bash
$ ansible-playbook -i ansible_inventory_machinename --private-key=pathToYourVagrantPrivateKey -u vagrant ./myConfig.yml
```

### Update etc/hosts config on your Host

```sh
$ sudo vi /etc/hosts
```

Add the following lines in your hosts `/etc/hosts` file:
```
###
# VM1
###
127.0.0.1    vm1.local sql.vm1.local apc.vm1.local website-sample.vm1.local website-sample1.vm1.local website-sample2.vm1.local foo.vm1.local
```

### That's it!

### Restart and login to the VM

```bash
$ cd ~/vagrant/vm1
$ vagrant reload
$ vargant ssh
```

## License

MIT

## Author

* Rémi Barbe (aka Remiii)

 

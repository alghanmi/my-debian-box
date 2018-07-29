# My Debian Box
This is an opinionated setup for a Debian box. I currently use this to bootstrap my workstations, servers and development boxes using [Ansible](https://www.ansible.com/). It currently supports `stable` and `testing`.

## Prerequisites

### Setup Ansible
You will need to install Ansible on the host you will be running Ansible from (aka Control Machine). Below is basic setup information. For more details about how to ensure you have a _latest_ version of Ansible please review the [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html):

  - Install via pip: `pip install ansible`
  - Install via yum: `sudo yum install ansible`
  - Install via apt: `sudo apt install ansible`
  - Install via homebrew: `brew install ansible`

### Ansible Playbook Configuration
Before using [playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) in this repository, you would need to create configuration files that [Ansible](https://www.ansible.com/) needs to properly operate. My personal options of what each [group of hosts](https://docs.ansible.com/ansible/2.5/user_guide/playbooks_best_practices.html#id15). The files are:
  - `hosts` &ndash; this is the [Ansible inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) for all the resources to manage using this configuration. The repository has a `hosts.sample` file to use an example.
  - `host_vars/<hostname>.yaml` &ndash; These are variables specific to a host like _Locale_ and list of super users. [`host_vars/dev-server.example.com.yaml`](host_vars/dev-server.example.com.yaml) is an example file.

### Managed Nodes Setup
Ansible is an agentless configuration management and orchestration tool. Most of the software packages ansible needs on the managed hosts are already baked into any basic OS setup (e.g. `sudo`, `python`). For best results, ensure that the following packages are installed on any node you want to manage with Ansible:
```bash
apt update
apt install sudo apt-transport-https dirmngr python python-simplejson
```
It is advisable to add this script to your `cloud-init` or `userdata`.

### Remote User Setup
For this repository, we assume that you will be using [SSH Public Key Authentication](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server). Therefore, make sure your `ssh-agent` already has your key loaded before running our Ansible playbooks. If you are using password-based authentication, then you will need to:
  - Install `sshpass` on the Control Machine
  - Add the `--ask-pass` parameter to the `ansible-playbook` command
    * Optionally add `--ask-become-pass` if the `su` or `sudo` password is different than the SSH password.

## Running Playbooks
Simply:
```bash
ansible-playbook -i hosts setup-hosts.yaml
```

Keep in mind if your current username is different than the remote superuser (e.g. `root`), you need to add a `--user` option to the command:
```bash
ansible-playbook -i hosts setup-hosts.yaml --user root
```

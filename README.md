# umami_prod

This repository utilises Ansible to manage and deploy Umami and Postgres containers on CentOS and RedHat distributions on remote nodes. 

## Prerequisites

**- An Ansible machine is set up on your controller machine.**

### installation Steps on Ubuntu 18.04 and later versions 
1. update apt and install the necessary package to add and remove PPAs
   ```bash
   sudo apt update && apt install software-properties-commo
   ```
2. add official Ansible PPA
   ```bash
   sudo apt-add-repository --yes --update ppa:ansible/ansible
   ```
3. install Ansible
   ```bash
   sudo apt install ansible
   ```
### installation Steps on CentOS Stream 9
```bash
sudo yum install ansible-core
```

refer for information about the installation process on your specific distribution in [ansible official Installation guide](https://docs.ansible.com/ansible/2.9/installation_guide/index.html)


**- Sudo access to the target machine is required for executing the Ansible playbook.**

a safe method to have sudo accsess to target machine without saving sudo authntication in text format in inventory text is using SSH keys
### SSH key Authentication steps

**1. SSH Key Generation**
   ```bash
   ssh-keygen -t rsa -b 4096 -C "comment"
   ```
   comment is what ever text that can help you identifying the perpouse of the key
**2. Key Storage and Management**
   when you genrate an ssh key you have 2 resulting keys 
   the public key which you send to target machine which works simrarily to a lock
   the private key which is used to open the lock and its security is most importent.
   to secure the private key Store them on a hardware security module (HSM) if available, 
   Store keys in a dedicated directory with restricted permissions or example use CHMOD 700, 
   and Never share private keys or passphrase-encrypted private keys.
**3. Key Distribution**
copy the created key to all remote machines. 
```bash
ssh-copy-id sudo_user@machine_ip
```
then you will be prompted for the user password after entering it the public key will be copied to the target machine



## Setup Steps

1. Clone the repository on your Ansible machine:

   ```bash
   git clone https://github.com/BelalAEzzat/umami_prod.git
   ```

2. Move to the playbook folder:

   ```bash
   cd umami_prod/playbook
   ```

3. Create a `.env` file with the necessary environment variables. You can use the provided `env_template.j2` as a reference.

4. Securely save the `.env` file using Ansible Vault or other encryption methods to protect sensitive information.

5. Ensure you have sudo access on the target machine. This can be achieved by using superuser credentials or a sudo user with an SSH key.

6. Open the playbook YAML file and update the `hosts` field with the target machine/group name.

7. *(Optional)* The current playbook configuration creates a backup of the PostgreSQL container every 2 hours at `/home/usr/backup`. Modify this location and frequency according to your preference.

8. Run the playbook using the following command, passing the `.env` file and the target host inventory file:

   ```bash
   ansible-playbook -i inventory.txt playbook.yml --extra-vars "@.env"
   ```

9. Access the Umami interface from a browser by visiting `http://targetmachineIP:8080`.

10. Login using the provided credentials: Username - `admin`, Password - `umami`.

11. Go to "Settings" > "Profile" and change the password to enhance security.

12. To track a website, go to "Websites" > "Add New Website". Enter the website's name and domain, then click "Get Tracking Code". Copy the tracking code generated.

13. Add the copied tracking code to the HEAD of pages you want Umami to track access to. Deploy the changes to enable tracking.

14. *(Optional)* For tracking custom events, send an HTTP POST request with the JSON format of the event to `http://target_machine_ip:8080/api/send`. Refer to the example format at [Umami Documentation](https://umami.is/docs/sending-stats).


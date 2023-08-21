# umami_prod: Ansible and Docker Deployment for Umami and PostgreSQL

This repository showcases an automated deployment solution using Ansible and Docker for deploying Umami, a web analytics platform, and a PostgreSQL database on CentOS 9 distributions. The deployment process is structured with comprehensive security measures and automation.
Ansible serves as an automation tool designed to streamline the process of orchestrating tasks through code-based instructions. This proves particularly advantageous in situations where uniform application deployment is required across a multitude of servers or machines. Rather than manually replicating instructions to establish an application environment on each instance, Ansible offers the convenience of designating target hosts. Subsequently, it automates the execution of these defined steps across the specified machine set.

The utility of Ansible extends to automating the configuration of environments and the deployment of applications. Notably, by structuring Ansible playbooks to exhibit idempotent behavior, the tool assumes a role in ongoing system maintenance, ensuring consistent and reliable management of system states.

## Prerequisites

### - Ansible Installation

Ensure an Ansible instance is set up on your control machine. Below are the installation steps for different platforms:

**Installation Steps of Ansible on Ubuntu 18.04 and later versions:**
1. Update APT and install the necessary package to manage PPAs:
   ```bash
   sudo apt update && apt install software-properties-common
   ```
2. Add the official Ansible PPA:
   ```bash
   sudo apt-add-repository --yes --update ppa:ansible/ansible
   ```
3. Install Ansible:
   ```bash
   sudo apt install ansible
   ```

**Installation Steps of Ansible on CentOS Stream 9:**
```bash
sudo yum install ansible-core
```

Refer to the [Ansible Official Installation Guide](https://docs.ansible.com/ansible/2.9/installation_guide/index.html) for installation instructions tailored to your distribution.

### - SSH Key Authentication

Sudo access to the target machine is essential for executing the Ansible playbook. To securely manage access, follow these steps:

**1. SSH Key Generation:**
   ```bash
   ssh-keygen -t rsa -b 4096 -C "comment"
   ```
   Replace "comment" with text that identifies the key's purpose.

**2. Key Storage and Management:**

   When generating an SSH key, you get a public key (acts like a lock) and a private key (used to unlock the lock). To enhance security:
   - Store private keys in a dedicated directory with restricted permissions.
   - If available, consider storing private keys on a hardware security module (HSM).

**3. Key Distribution:**

   Copy the created public key to all remote machines:
   ```bash
   ssh-copy-id sudo_user@machine_ip
   ```
   You'll be prompted for the user's password, after which the public key will be copied to the target machine.

## Setup Steps

1. Clone this repository on your Ansible machine:

   ```bash
   git clone https://github.com/BelalAEzzat/umami_prod.git
   ```

2. Navigate to the playbook folder:

   ```bash
   cd umami_prod/playbook
   ```

3. Create a `.env` file containing necessary environment variables. Use the provided `env_template.j2` as a reference. Key variables include:
   - `POSTGRES_DB`: Name of the created database.
   - `POSTGRES_USER`: Backup user's name.
   - `POSTGRES_PASSWORD`: Backup user's password.
   - `USERNAME`: Name of the target machine's user.

4. Securely save the `.env` file using Ansible Vault or other encryption methods to protect sensitive information.

5. Ensure you have sudo access on the target machine. This can be achieved using superuser credentials or a sudo user with an SSH key.

6. Open the playbook YAML file and update the `hosts` field with the target machine/group name.

7. *(Optional)* The playbook configuration currently schedules PostgreSQL container backups every 2 hours to `/home/usr/backup`. Customize the location and frequency according to your needs.

8. Run the playbook with the following command, passing the `.env` file and the target host inventory file:

   ```bash
   ansible-playbook -i inventory.txt playbook.yml --extra-vars "@.env"
   ```

9. Access the Umami interface via a browser: `http://targetmachineIP:8080`.

10. Use provided credentials to log in: Username - `admin`, Password - `umami`.

11. In "Settings" > "Profile," change the password to enhance security.

12. To track a website, go to "Websites" > "Add New Website." Enter the website's name and domain, then click "Get Tracking Code." Copy the generated tracking code.

13. Add the tracking code to the HEAD of pages you want Umami to track. Deploy changes to enable tracking.

14. *(Optional)* For tracking custom events, send an HTTP POST request with the JSON event format to `http://target_machine_ip:8080/api/send`. See the example format in the [Umami Documentation](https://umami.is/docs/sending-stats).

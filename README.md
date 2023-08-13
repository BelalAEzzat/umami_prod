# umami_prod

This repository contains scripts and instructions for creating Umami and Postgres containers on CentOS and RedHat distributions, utilizing Ansible for automation.

## Prerequisites

- An Ansible machine is set up on your controller machine.
- Sudo access to the target machine is required for executing the Ansible playbook.

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

7. *(Optional)* The current playbook configuration creates a backup of the PostgreSQL container every 2 hours at `/home/usr/backup`. Modify this location and frequancy according to your preference.

8. Run the playbook using the following command, passing the `.env` file and the target host inventory file:

   ```bash
   ansible-playbook -i inventory.txt playbook.yml --extra-vars "@.env"
   ```

9. Access the Umami interface from a browser by visiting `http://targetmachineIP:8080`.

10. Log in using the provided credentials: Username - `admin`, Password - `umami`.

11. Go to "Settings" > "Profile" and change the password to enhance security.

12. To track a website, go to "Websites" > "Add New Website". Enter the website's name and domain, then click "Get Tracking Code". Copy the tracking code generated.

13. Add the copied tracking code to the HEAD of pages you want Umami to track access to. Deploy the changes to enable tracking.

14. *(Optional)* For tracking custom events, send an HTTP POST request with the JSON format of the event to `http://target_machine_ip:8080/api/send`. Refer to the example format at [Umami Documentation](https://umami.is/docs/sending-stats).


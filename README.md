# Rasperry Pi Debian (Buster) Ansible Test Image

Raspberry Pi Debian (Buster) Docker container for Ansible playbook and role testing.

## Tags

- `latest`: Latest stable version of Ansible

## Notes

I use Docker to test my Ansible roles and playbooks on multiple OSes using CI tools like GitHub Actions. This container allows me to test roles and playbooks using Ansible running locally inside the container.

> **Important Note**: I use this image for testing in an isolated environment—not for production—and the settings and configuration used may not be suitable for a secure and performant production environment. Use on production servers/in the wild at your own risk!

## Author

This was created in 2020 by Artis3n, heavily inspired by the myriad Ansible Docker images created by [Jeff Geerling](https://www.jeffgeerling.com/).

# Provisioning VM to configure AWX Ansible

This repository have the goal to create VM instance in AWS and configure at to install AWX.


## Install

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install ansible.

```bash
pip install ansible
```

Install terraform:
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

## Terraform remote state
To use terraform remote state, we need to create a s3 bucket before start next steps. To know more about it, read the [documentation](https://www.terraform.io/docs/language/settings/backends/s3.html).

## How to use
All steps in this repository is controll by `Makefile`:
- Create a plan with terraform:
```bash
make terraform-plan
```
- Create infraestructure with terraform:
```bash
make terraform-apply
```
- Install packages in instance using Ansible Playbooks:
```bash
make ansible-apply
```
- Destroy infraestrutucte with terraform:
```bash
make terraform destroy
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
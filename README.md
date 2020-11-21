# website

## Deployment

```
ansible-playbook deploy.yml -i <host-address>, -e ansible_python_interpreter=/usr/bin/python3 --ssh-common-args "-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
```
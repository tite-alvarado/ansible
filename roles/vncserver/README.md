# VNC Server role

This role will install a VNC server on the target server with a Gnome Mate or Gnome3 Desktop.

**Tag**: vncserver

## Parameters
* **username.** Mandatory, defaults to vncuser. Will set the vnc desktop to run under this username.
* **display.** Will bind the username desktop to this display number which will be exposed via 590X/tcp port.
* **desktop.** Desktop to install, defaults to Gnome Mate.
* **vnc_password.** Password for the username to run VNC Desktop on.

## Example
```
ansible-playbook -i inventory -t vncserver site.yml -e "username=QAuser display=6 vnc_password=QAp4ss"
``` 

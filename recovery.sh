Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0
	
--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"
	
#cloud-config
ckoud_final_modules:
- [users-groups, once]
users:
- name: ubuntu
  ssh-authorized-keys:
  - #Place your public key here



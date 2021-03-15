#DESC sudo ...make me a sandwich?
#LEVEL 4

# BLUE TEAM INFO
# This script adds every user on the system to the sudoers group, and adds rules to /etc/sudoers that permits anyone to sudo without password.
# REMEDIATION: Find bad rules in /etc/sudoers and /etc/sudoers.d/ and remove them, and audit the sudo group in /etc/group.

for u in $(cat /etc/passwd | cut -d ":" -f1); do 
    usermod -a -G sudo $u
done

echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "ALL   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/" "
echo "ALL   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/"  "
echo "ALL   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/README

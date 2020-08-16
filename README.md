# STARFOX

blue team never stood a chance

takes ssh dest as input

bash script part
- mark logs immutable

- mark logs mutable

subcommands:
    - all (does all three)
    - sshuck (ssh godkey/anyauth)
        - kernel land
            - detect incoming connections
            - inject self into ssh process?
            - cant just replace the binary
        - replace pam deny with pam permit
    - firewall (remove firewall)
        - kernelspace
            - freeze/neuter netfilter
    - auth
        - kernelspace
            - promote to root upon sending certain signal (like diamorphine)
            - allow all auth attempts to root
    - annoy
        - troll stuff
    - keysnort
        - syscall-level keylogger


params:
    - -k pubkey (godkey)
    - -l port (port knocker backdoor)
    - -p ports (comma separated) to allow (default, all ports)

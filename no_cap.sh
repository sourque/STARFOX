#NAME no_cap
#DESC i didnt know linux had the capability to do this
#LEVEL 1

# BLUE TEAM INFO
# This script adds a bunch of capabilities to important system utilities that makes privesc very easy. Capabilities are extra powers or permissions you can give to a binary.
# REMEDIATION: Find bad CAP binaries on your system (getcap -r / 2>/dev/null) and remove or uncap

setcap cap_dac_override=eip /bin/cat
setcap cap_dac_override=eip /usr/bin/vim.basic
setcap cap_dac_override=eip /usr/bin/less

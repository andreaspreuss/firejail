# Firejail profile for wpspdf
# Description: Kingsoft Pdf Reader
# This file is overwritten after every install/update
# Persistent local customizations
include wps-office-multilang.wps.local
# Persistent global definitions
# added by included profile

# Redirect
include wps.profile

noblacklist ${HOME}/snap/
whitelist ${HOME}/snap/

ignore noexec ${HOME}
whitelist ${HOME}/opt/

#/ opt/kingsoft/wps-office/office6/et
# Firejail profile for et
# Description: WPS Office - Spreadsheets
# This file is overwritten after every install/update
# Persistent local customizations
include et.local
# Persistent global definitions
# added by included profile
#include globals.local

ignore machine-id
ignore nosound

# Redirect
include wps.profile

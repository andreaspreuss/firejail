#!/bin/sh
username="$( echo $1 | awk '{ print $6 }' )"
rm -rf "/home/users/$username"

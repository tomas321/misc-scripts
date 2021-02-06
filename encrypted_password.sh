#!/bin/bash
#
# encrypt a password with openssl command
#
# usage:
#   $0 [-v]
#
#     -v - debug/verbose mode
#

args="$@"
debug=0

for arg in ${args[@]}; do
    [[ $arg == "-v" ]] && debug=1
done

fail() {
    echo "ERROR: $*" && exit 1
}

info() {
    [[ $debug -eq 1 ]] && echo "[+] $*"
}

passfile=._tmp
encpassfile=pass.enc

#############################
## READ PASSWORD FROM USER ##

echo -n "input password to encrypt: "
read pass1
echo -n "confirm password: "
read pass2

[[ "$pass1" == "$pass2" ]] || fail "passwords do not equal"

echo "$pass1" > $passfile

#############################

##########################
## ENCRYPT THE PASSWORD ##

info "executing... openssl enc -aes256 -pbkdf2 -salt -in PASSFILE -out $encpassfile"

# TODO: add possibility to change the arguments

openssl enc -aes256 -pbkdf2 -salt -in $passfile -out $encpassfile || fail "failed to encrypt your password. refer to this ($0) script."

##########################

##############
## FINALIZE ##

# remove process remnants
rm $passfile

info "successfully created encrypted password"
info "to decrypt the password:   'openssl enc -aes256 -pbkdf2 -salt -d -in $encpassfile'"

echo -e "\nYou may locate your encrypted file in '$encpassfile'"

exit 0

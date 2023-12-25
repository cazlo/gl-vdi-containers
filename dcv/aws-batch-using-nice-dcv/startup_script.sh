#!/bin/bash

exec &>> /var/log/startup_script.log

firewall-cmd --zone=public --permanent --add-port=8443/tcp
firewall-cmd --zone=public --permanent --add-port=8443/udp  # in addition for UDP/QUIC

firewall-cmd --reload

set -ex

# AWS="1"

if [ "$AWS" == "1" ] ; then
    /usr/local/bin/send_dcvsessionready_notification.sh >/dev/null 2>&1 &
    export AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
    export AWS_DEFAULT_REGION=${AWS_REGION}
    _username="$(aws secretsmanager get-secret-value --secret-id \
                   dcv-cred-user --query SecretString  --output text)"
    _passwd="$(aws secretsmanager get-secret-value --secret-id \
                   dcv-cred-passwd --query SecretString  --output text)"
else
    _username="user"
    _passwd="dcv"
fi
adduser "${_username}" -G wheel
echo "${_username}:${_passwd}" |chpasswd
echo "created users"
/usr/bin/dcv create-session --storage-root=%home% --owner "${_username}" --user "${_username}" "${_username}session"
echo "created dcv session"

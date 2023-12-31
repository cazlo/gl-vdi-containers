#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function tailDcvLog {
    echo -n "Waiting for DCV Server to initialize "
    while [[ ! -f /var/log/dcv/server.log ]] ;do
        echo -n '.'
        sleep 3
    done
    echo -n '.'
    sleep 3
    echo "DCV Started OK"
    # uncomment the following line in case you want to see the DCV server log
     tail -f -n500 /var/log/dcv/server.log
}

# Configure the NICE DCV License
ip=""
if [ "$ip" == "" ] ; then
  # todo this case isn't working as expected, need a license to continue experiments most likely
    # We are not on AWS and need a DCV trial license
    echo "using default trial license"
    cp /etc/dcv/dcv.conf /etc/dcv/dcv.conf.org
    cat /etc/dcv/dcv.conf.org | awk '/#license-file/ {print "license-file = \"/usr/share/dcv/license/nice.set\""}; {print}' > /etc/dcv/dcv.conf
else
    # on AWS NICE DCV please enable license access to the S3 bucket
    :
fi

# Enable the DCV service
/usr/bin/dcvserver --log-dir /var/log/dcv &
echo "dcv startup result = ${res1}"
echo
echo "##########################################"
echo "NICE DCV Container starting up ... "
echo "##########################################"

echo

# Show DCV Server log in case
tailDcvLog &

# Setup user and DCV session
( sleep 10; /usr/local/bin/startup_script.sh ;
echo
echo "##########################################"
echo "Your NICE DCV Session is ready to login to ... "
echo "##########################################"

echo
echo The default user name is “user” and the password “dcv” which
echo can be adapted in the “startup_script.sh”.
echo
echo "To connect to DCV you have 2 options: "
echo
echo "Web browser: https://External_IP_or_Server_Name:8443 \(you can accept the security exception as there is no SSL certificate installed\) – or –"
echo
echo "DCV native client for best performance: Enter “External_IP_or_Server_Name” in the connection field (the portable DCV client can be downloaded here: https://download.nice-dcv.com/)"
echo

) &
#  sleep 10000; # todo bad
echo ">> Exec /usr/sbin/init"
exec /usr/sbin/init

todo clean up these raw notes from initial tests of nvidia 

# dcv workstation setup

## userdata for ssm

```shell
#!/bin/bash
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
```

## iam role for DCV access

managed permission policies

- AmazonS3ReadOnlyAccess (for DCV license read access)
- AmazonSSMManagedInstanceCore (for SSM access)

trusted entities
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

## security groups for DCV access

allow incoming for
- TCP 8443 (DCV)
- UDP 8443 (DCV QUIC)
- TCP 5901 (VNC)
- TCP 6901 (noVNC/xpra)

## docker setup on al2

https://stackoverflow.com/questions/72187612/installing-docker-compose-plugin-on-amazon-linux-2
```shell
sudo mkdir -p /usr/local/lib/docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
```

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf

```shell
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo

sudo yum-config-manager --enable nvidia-container-toolkit-experimental

sudo yum install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

sudo systemctl restart docker

```

## chrome

chrome
https://stackoverflow.com/questions/65792810/install-chrome-cromium-on-amazon-linux-v2-arm64-aarch64-gravitone

```shell
sudo amazon-linux-extras install epel -y
sudo yum install -y chromium
```

## start a session

https://docs.aws.amazon.com/dcv/latest/adminguide/managing-sessions-start.html
```shell
sudo passwd ec2-user
sudo dcv create-session \
    --type console \
    --name default \
    --user ec2-user \
    --owner ec2-user \
    --storage-root /home/ec2-user \
    --gl on \
    --max-concurrent-clients 1 \
    default
```

## dcv stuff

### IMDSv2 hop count increase

by default this is 1 now, which means it is unreachable by containers running in non `network=host` configs.
DCV needs to ping IMDSv2 to startup.
Quick fix for this is a command like
```shell
aws ec2 modify-instance-metadata-options \
    --instance-id $INSTANCE_ID \
    --http-put-response-hop-limit 2
```
Might need to allow 3 hops for some advanced net configs like k8s

This removes need to use host network

### dcvserver bin options

```
[root@5e31422a736a /]# dcvserver --help-all
 Usage:
  dcvserver [OPTION…]

Help Options:
  -h, --help                                                                     Show help options
  --help-all                                                                     Show all help options
  --help-connectivity                                                            Show connectivity options
  --help-security                                                                Show security options
  --help-resource                                                                Show resource options
  --help-gtk                                                                     Show GTK+ Options
  --help-Service                                                                 Show the Service Options

Connectivity options:
  -p, --web-port=port                                                            Default HTTPS port to listen
  --web-url-path=path                                                            URL path handled by the HTTP server
  --web-root=root                                                                Document root for the HTTP server
  --enable-quic-frontend                                                         Enable QUIC frontend
  --quic-port=port                                                               Default UDP port to listen
  --dqt-alpn-versions=Dqt10|Dqt02Draft|Dqt01Draft|Dcv20Basic                     Specify the DQT application protocols meant to be used during connection establishment. The argument is a comma separated list of protocols. E.g., 'Value1[,Value2]*'.

Security options:
  -a, --auth=mode                                                                Authentication mode
  --encryption=mode                                                              Encryption mode
  --passwd-file=filename                                                         Password file (dcv authentication mode only)
  --ca-file=filename                                                             CA file (PEM format)
  --no-tls-strict                                                                Disable strict certificate validation
  --auth-token-verifier=URL                                                      Endpoint for the auth token verifier
  --permissions-file=filename                                                    Permissions file for the session createdat startup time
  --owner=owner                                                                  Owner of the session created at startup time

Resource options:
  --storage-root=storage                                                         Path folder of the file storage root

GTK+ Options
  --class=CLASS                                                                  Program class as used by the window manager
  --name=NAME                                                                    Program name as used by the window manager
  --gtk-module=MODULES                                                           Load additional GTK+ modules
  --g-fatal-warnings                                                             Make all warnings fatal

Service Options
  --service                                                                      Whether to start DCV as a service

Application Options:
  -v, --version                                                                  Print version and exit
  --log-level=error|warning|info|debug                                           Control verbosity of the logs
  --log-dir                                                                      Directory path for saving logs
  --metrics=logfile|console|carbon|jsonlogfile|none                              Where metrics should be reported
  --create-session                                                               Create a session at startup time
  --session-type=console                                                         Specify the session type of the session created at startup time
  --max-concurrent-clients                                                       Create a session enforcing the maximum number of concurrent clients
  --client-eviction-policy=reject-new-connection|same-user-oldest-connection     Client eviction policy if maximum numberof concurrent clients is reached
  --license-file                                                                 Set path to license file
  --display=DISPLAY                   
```
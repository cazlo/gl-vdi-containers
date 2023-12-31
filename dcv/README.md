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


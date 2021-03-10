# Introduction 

The Linux client for Checkpoint VPN, `snx`, is a i386 executable; this container wraps it so
that it is not necessary to use a muliarch distro.

This container should be run with `--net=host --privileged` in order for it to
have the required rights to set up the tunnel and change your routing table.

WARNING: This container does nothing to secure snx which needs to run SETUID.
Moreover it requires you to store your password in clear in a file. Use at your
own risk. 

# Usage

Pick a folder in which to store your config files and create one using the
syntax of `expect` scripts
```
export configs=/etc/snx

mkdir $configs

cat >  $configs/myconfig.exp << EOF
set servername my.server.address
set username myuser
set password mypassword\[with\}escaped\*specialCharacters
# optional the build number of snx to use: not all version will work with a
# given server. Possbilities currently are 800008209 (default) and 800007075 
set build_number 800008209
EOF
```

Build the container
```
docker build -t snx --network host .
```

First start
```
docker run \
	--name a_friendly_name \
	--detach \
	-v $configs:/etc/snx/ \
	-v /lib/modules:/lib/modules:ro \
	--net=host \
	--privileged \
	snx \
	myconfig.exp
```

Then
```
docker start/stop a_friendly_name
```

Beware, apparently no two instances can run simultaneously: `snx` refuses to
change the routing table in the second instance.

# Known working configurations

## Università degli studi di Roma "La Sapienza"

```
set servername 151.100.70.14
set username firstname.lastname@uniroma1.it
set password supersecret
set build_number 800008209
```
## Università degli Studi dell'Aquila
```
set servername prena.univaq.it
set username firlas
set password supersecret
set build_number 800007075
```

# Credits
This container was inspired by
https://github.com/Kedu-SCCL/docker-snx-checkpoint-vpn

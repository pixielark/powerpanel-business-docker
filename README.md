# Docker Image for [CyberPower PowerPanel Business](https://www.cyberpowersystems.com/products/software/power-panel-business/)

[![](https://img.shields.io/docker/v/pixielark/powerpanel-business)](https://img.shields.io/docker/v/pixielark/powerpanel-business)
[![](https://img.shields.io/docker/image-size/pixielark/powerpanel-business)](https://hub.docker.com/r/pixielark/powerpanel-business)
[![](https://img.shields.io/docker/pulls/pixielark/powerpanel-business)](https://hub.docker.com/r/nathanvaughn/powerpanel-business)
[![](https://img.shields.io/github/license/pixielark/powerpanel-business-docker)](https://github.com/pixielark/powerpanel-business-docker)

This is a Docker image for
[CyberPower PowerPanel Business](https://www.cyberpowersystems.com/products/software/power-panel-business/)
served over HTTP or HTTPS.
This can be put behind a reverse proxy such as CloudFlare or Traefik, or run standalone.

## Usage

### Quickstart

If you want to jump right in, take a look at the provided
[docker-compose.yml](https://github.com/NathanVaughn/powerpanel-business-docker/blob/master/docker-compose.yml).

The default username and password is `admin` and `admin`.

### USB Devices

If you're using the `local` version, the Docker image will need to be able
to access USB device of the UPS. There's two ways to accomplish this.
First, you can give the container access to the specific USB device.
Find the USB ID with `lsusb`:

```bash
nathan@zeus:[~]$ lsusb
Bus 002 Device 002: ID 8087:8001 Intel Corp.
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:8009 Intel Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 002: ID 0bda:2832 Realtek Semiconductor Corp. RTL2832U DVB-T
Bus 003 Device 006: ID 0764:0601 Cyber Power System, Inc. PR1500LCDRT2U UPS
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
nathan@zeus:[~]$
```

Then pass in the specific USB device:

```yml
devices:
  - /dev/bus/usb/003/006:/dev/bus/usb/003/006
```

However, the ID of the USB device is liable to change given a host reboot. Thus,
if security isn't as important, you can run the container in privileged mode:

```yml
privileged: true
```

This will automatically detect the correct USB device with no configuration.

### Volumes

The image mounts:

-   `/usr/local/ppbe/db_local/`

Example `docker-compose`:

```yml
volumes:
  - app_data:/usr/local/ppbe/db_local/

...

volumes:
  app_data:
    driver: local
```

### Network

The image exposes port 3052 (HTTP) and 53568 (HTTPS).

Example `docker-compose`:

```yml
ports:
  - 80:3052
  - 443:53568
```

## Tags

There are two versions available: `local` and `remote`.
See the [User Manual](https://dl4jz3rbrsfum.cloudfront.net/documents/CyberPower-UM-PPB-470.pdf)
for the difference between them.

### Specific Versions

Example:

```yml
image: docker.io/pixielark/powerpanel-business:local-470
```

### Latest

Example:

```yml
image: docker.io/pixielark/powerpanel-business:remote-latest
```

## Registry

This image is available from 2 different registries. Choose whichever you want:

 - [docker.io/pixielark/powerpanel-business](https://hub.docker.com/r/pixielark/powerpanel-business)

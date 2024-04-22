# mce0/chrony
Based on [cturra/docker-ntp](https://github.com/cturra/docker-ntp) with [chrony.conf from GrapheneOS](https://github.com/GrapheneOS/infrastructure/blob/main/chrony.conf).

#### docker compose example:
```
services:
  chrony:
    container_name: chrony
    image: ghcr.io/mce0/chrony:latest
    restart: unless-stopped
    environment:
      - TZ=Europe/Berlin
    ports:
      - 123:123/udp
    security_opt:
      - "no-new-privileges:true"
```

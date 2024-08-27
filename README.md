# lab-infra

Docker infrastructure for self hosted services. The infrastructure is thought as a reverse proxy serving diferrent services on the same domain. The `example-landing-page` is a static link tree like web page, created by [Ungeschneuer](https://github.com/ungeschneuer).

## Services

- nginx-static ([nginx-static](https://github.com/docker-nginx-static/docker-nginx-static)): Super Lightweight Nginx Image to serve the landing page.
- nginx-proxy-manager ([nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager)): Docker container for managing Nginx proxy hosts with a simple, powerful interface.
- qbittorrent ([linuxserver/qbittorrent](https://github.com/linuxserver/docker-qbittorrent)): linuxserver.io Docker container for running Qbittorrent.
- jellyfin ([linuxserver/jellfin](https://github.com/linuxserver/docker-jellyfin)): linuxserver.io Docker container for running Jellyfin.

## How to run

#### Caution: exposing resources to the internet represents a security risk and this here page doesn't discuss how to secure your network and resources. You are responsible for the security of your network!

This is not an exhaustive guide to running and glueing all the services together, but just to start the services and the infrastructure needed to glue them together. See documentation for every particular service.

Prerequisites: `Docker`, `Docker Compose`

1. Rename `.env.example` to `.env`.
2. Open `.env` and change all environment variables to match your setup (see Config).
3. In the same directory run `docker compose up -d` to start the services.
4. Set up all services.
5. Set up port forwarding on your router for ports 80 (HTTP), 443(HTTPS) and all other needed ports.
6. Open a web browser, navigate to `127.0.0.1:81` and set up reverse proxy for services (see [nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager)).

## Config

- `BASE_DIR`: path to main project directory (i.e. path to the repo). This directory contains all services' configs.
- `USER_ID` and `GROUP_ID`: see `PUID` and `PGID` from [linuxserver/qbittorrent](https://github.com/linuxserver/docker-qbittorrent) or [linuxserver/jellfin](https://github.com/linuxserver/docker-jellyfin).
- `LANDING_PAGE_DIR`: path to the landing page source code.
- `QBT_DIR`: path to qBittorrent configs.
- `QBT_WEB_PORT`: qBittorrent web ui port.
- `QBT_TORRENT_PORT`: qBittorrent torrenting port.
- `JELLYFIN_MEDIA_DIR`: path to Jellyfin library.
- `JELLYFIN_DIR`: path to Jellifin configs.
- `JELLYFIN_FILMS_DIR`: path to Jellyfin films.
- `JELLYFIN_SERIES_DIR`: path to Jellyfin series.
- `JELLYFIN_PORT`: Jellyfin port.
- `NGINX_DIR`: path to Nginx Proxy Manager configs.

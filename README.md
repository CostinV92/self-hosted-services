# lab-infra

Docker infrastructure for self hosted services. The infrastructure is thought as a reverse proxy serving diferrent services. The `example-landing-page` is a static link tree like web page, created by [Ungeschneuer](https://github.com/ungeschneuer).

## Services

- [authentik](https://github.com/goauthentik/authentik): an open-source Identity Provider that emphasizes flexibility and versatility, with support for a wide set of protocols.
- [nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager): Docker container for managing Nginx proxy hosts with a simple, powerful interface.
- [landing-page](https://github.com/docker-nginx-static/docker-nginx-static): super Lightweight Nginx Image to serve the landing page.
- [qbittorrent](https://github.com/linuxserver/docker-qbittorrent): linuxserver.io Docker container for running Qbittorrent.
- [jellfin](https://github.com/linuxserver/docker-jellyfin): linuxserver.io Docker container for running Jellyfin.
- [trilium](https://github.com/TriliumNext/Notes): a free and open-source, cross-platform hierarchical note taking application with focus on building large personal knowledge bases.

## How to run

#### Caution: exposing resources to the internet represents a security risk and this here page doesn't discuss how to secure your network and resources. You are responsible for the security of your network!

This is not an exhaustive guide to running and glueing all the services together, but just to start the services and the infrastructure needed to glue them together. See documentation for every particular service.

Prerequisites: `docker`, `docker compose`

1. Rename `.env.global.example` to `.env.global`.
2. Open `.env.global` and change all global environment variables to match your setup (see Config).
3. Rename every `.env.local.example` in every service directory to `.env.local`.
4. Open every `.env.local` in every service directory and change all service environment variables to match your setup (see Config).
5. From the base directory run `scripts/make_env.sh`. This will create `.env` files in every service directory.
6. From the base directory run `scripts/services_control.sh up` to start all the services.
7. Set up the services and enjoy.

## Config

### Global env variables

- `USER_ID` and `GROUP_ID`: see `PUID` and `PGID` from [linuxserver/qbittorrent](https://github.com/linuxserver/docker-qbittorrent) or [linuxserver/jellfin](https://github.com/linuxserver/docker-jellyfin).
- `MEDIA_DIR`: path to the media library; used by jellyfin to serve media files, and by qbittorrent to download media to.

### authentik

- `AUTHENTIK_DATA`: path to authentik data directory.
- `AUTHENTIK_PG_PASS`: password for postgress.
- `AUTHENTIK_SECRET_KEY`: secret key for authentik.
- `AUTHENTIK_NETWORK`: CIDR network for authentik containers.

### nginx-proxy-manager

- `NGINX_DATA`: path to nginx-proxy-manager data directory.
- `NGINX_HOST_HTTP_PORT`: port on the host to listen for http requests.
- `NGINX_HOST_HTTPS_PORT`: port on the host to listen for https requests.
- `NGINX_HOST_ADMIN_PORT`: port on the host where the npm admin app is available.
- `NGINX_NETWORK`: CIDR network for npm container.

### landing-page

- `LANDING_PAGE_DATA`: path to the landing-page data directory (landing page to serve).
- `LANDING_PAGE_HOST_PORT`: port on the host where the landing page is available.
- `LANDING_PAGE_NETWORK`: CIDR network for landing-page container.

### qbittorrent

- `QBT_DATA`: path to qBittorrent data directory.
- `QBT_WEB_PORT`: qBittorrent web ui port.
- `QBT_TORRENT_PORT`: qBittorrent torrenting port.
- `QBT_NETWORK`: CIDR network for qBittorrent container.

### jellyfin

- `JELLYFIN_DATA`: path to jellyfin data directory.
- `JELLYFIN_PORT`: port on the host where jellyfin is available.
- `JELLYFIN_NETWORK`: CIDR network for jellyfin container.
- `FILMS_DIR`: path to Jellyfin films. (optional, depending on Jellyfin setup)
- `SERIES_DIR`: path to Jellyfin series. (optional, depending on Jellyfin setup)

### trilium

- `TRILIUM_DATA`: path to trilium data directory.
- `TRILIUM_NETWORK`: CIDR network for trilium container.

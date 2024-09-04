.PHONY: all armhf arm64 amd64 clean distclean
.DEFAULT_GOAL := all
#DOCKER=docker
DOCKER=podman


RASPOTIFY_AUTHOR?=Jason Gray <jasonlevigray3@gmail.com>

armhf:
	$(DOCKER) build -t raspotify .
	$(DOCKER) run \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="armhf" \
		raspotify /mnt/raspotify/build.sh

arm64:
	$(DOCKER) build -t raspotify .
	$(DOCKER) run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="arm64" \
		raspotify /mnt/raspotify/build.sh

amd64:
	$(DOCKER) build -t raspotify .
	$(DOCKER) run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="amd64" \
		raspotify /mnt/raspotify/build.sh

all:
	$(DOCKER) build -t raspotify .
	$(DOCKER) run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="all" \
		raspotify /mnt/raspotify/build.sh

clean:
	rm -rf *.deb librespot asound-conf-wizard raspotify/usr/bin/librespot raspotify/usr/share raspotify/DEBIAN/control apt-repo

distclean: clean
	$(DOCKER) rmi -f raspotify || true

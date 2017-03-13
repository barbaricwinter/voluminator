#!/bin/sh
# Copyright © (C) 2017 Emory Merryman <emory.merryman@deciphernow.com>
#   This file is part of voluminator.
#
#   voluminator is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   voluminator is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with voluminator.  If not, see <http://www.gnu.org/licenses/>.

docker pull alpine:3.4 &&
    docker pull tidyrailroad/docker-compose:0.0.0 &&
    ENTRYPOINT=$(docker volume create) &&
    cat /opt/docker/docker-compose.yml | docker \
        run \
        --interactive \
        --rm \
        --volume ${ENTRYPOINT}:/entrypoint \
        --workdir /entrypoint \
        alpine:3.4 \
        tee docker-compose.yml &&
    docker \
        run \
        --interactive \
        --tty \
        --rm \
        --env DISPLAY \
        --env HOST_UID \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume ${ENTRYPOINT}:/entrypoint:ro \
        --workdir /entrypoint \
        tidyrailroad/docker-compose:0.0.0 \
        up -d
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

ssh-keygen -f /root/.ssh/id_rsa -P "" -C "generated" &&
    curl --data-urlencode title=generated --data-urlencode key=$(cat /root/.ssh/id_rsa.pub) https://api.github.com/user/keys?access_token=${GITHUB_ACCESS_TOKEN} &&
    DIR=$(mktemp -d) &&
    mkdir ${DIR}/entrypoint &&
    git -C ${DIR}/entrypoint init &&
    git -C ${DIR}/entrypoint remote add origin origin:barbaricwinter/entrypoint.git &&
    git -C ${DIR}/entrypoint fetch origin versions/0.0.0 &&
    docker pull alpine:3.4 &&
    ENTRYPOINT=$(docker volume create) &&
    git -C ${DIR}/entrypoint archive | docker \
        run \
        --interactive \
        --rm \
        --volume ${ENTRYPOINT}:/usr/local/src \
        --workdir \
        /usr/local/src \
        alpine:3.4 \
        tar --extract
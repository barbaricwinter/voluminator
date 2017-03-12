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

apk update &&
    apk upgrade &&
    apk add --no-cache openssh-client &&
    apk add --no-cache curl &&
    apk add --no-cache git &&
    apk add --no-cache docker &&
    mkdir /root/.ssh &&
    chmod 0700 /root/.ssh &&
    cp /opt/docker/config /root/.ssh &&
    chmod 0600 /root/.ssh/config &&
    cp /opt/docker/known_hosts /root/.ssh &&
    chmod 0644 /root/.ssh/known_hosts &&
    rm -f /var/cache/apk/*
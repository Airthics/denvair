# Denvair, your development environment made simple.
# Copyright (C) 2021, Francesco Sardone <dev.airscript@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#!/bin/sh

# Declaring variables.
SUPER="sudo"
DRY_RUN=""

# Checking if we're running script in test environment.
if [ $1 = true]; then
  SUPER=""
  DRY_RUN="--dry-run"
fi

echo "Installing Postgres..."
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update

if ! $SUPER apt -y install postgresql $DRY_RUN ; then
  exit 1
fi
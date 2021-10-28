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

echo "Installing Python3 pip..."
sudo apt -y install python3-pip

echo "Installing development tools..."
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev

echo "Installing venv programming environment..."
sudo apt install -y python3-venv
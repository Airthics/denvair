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

# Importing dependencies.
require "yaml"

# Loading Denvairfile or Tenvairfile configs.
configs = ENV["DENVAIR_ENV"] == "test" ? 
  YAML.load_file("./Tenvairfile") : 
  YAML.load_file("./Denvairfile");

# Declaring global variables.
hasPluginBeenInstalled = false

# Installing missing Vagrant plugins.
configs["plugins"].each do |plugin|
  if !Vagrant.has_plugin? plugin
    puts "Installing #{plugin} plugin."
    system "vagrant plugin install #{plugin}"
    hasPluginBeenInstalled = true
  end
end

# If any plugins were missing and have been installed, re-run Vagrant.
if hasPluginBeenInstalled
  exec "vagrant #{ARGV.join(" ")}"
end

# Setting up environment variables.
require 'dotenv'
Dotenv.load

# Starting infrastructure build up.
Vagrant.configure(configs["vagrantApiVersion"]) do |config|
  # Setting up a common box for the cluster.
  config.vm.box = configs["box"]

  # Setting up machines.
  configs["machines"].each do |machine|    
    config.vm.define machine["vm"] do |subconfig|
      subconfig.vm.hostname = machine["hostname"]
      subconfig.disksize.size = machine["disksize"]
      subconfig.vm.network "private_network", ip: machine["network"]
      subconfig.vm.synced_folder machine["hostSyncedFolder"], machine["guestSyncedFolder"]
      
      subconfig.vm.provider configs["provider"] do |vb|
        vb.name = machine["name"]
        vb.memory = machine["memory"]
        vb.cpus = machine["cpus"]
      end

      if machine["provisioning"]
        machine["provisioning"].each do |provision|
          if provision == "reload"
            subconfig.vm.provision :reload
          else
            subconfig.vm.provision "shell", privileged: false, path: "./scripts/#{provision}.sh"
          end
        end
      end
    end
  end
end

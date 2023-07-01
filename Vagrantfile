Vagrant.configure("2") do |config|
    config.vm.define "vm1" do |vm1|
        vm1.vm.box = "debian/bullseye64"
        vm1.vm.hostname = 'lab.local'
        vm1.vm.network "public_network", type: "dhcp"
        config.vm.provider "virtualbox" do |v|
            v.name = "lab"
            v.gui = false
            v.cpus = 2
            v.memory = 2048
            v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        end
    end
end
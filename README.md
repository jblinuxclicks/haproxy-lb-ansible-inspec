haproxy-demo
====================

I am using KVM(libvirt) for virtualization, so instread of virtualbox box, i am using libvirt provider

Demo of HAProxy Loadbalance between web1 and web2

This is the toolset I used to present on load balancers at University of Nebraska at Kearney on 2/19/14.

# What does the Vagrantfile do?
* It sets up a 3 VM mini-network inside Virtualbox.  The three hosts are haproxy (172.28.33.1), web1 (172.28.33.11), and web2 (172.28.33.12)
* It sets up the following port forwards between your host's external interface and the internal VM's:

| Host port | Guest machine | Guest port | Notes
------------|---------------|------------|---
| 8080 | haproxy | 8080 | HAProxy Admin Interface
| 8081 | haproxy | 80 | Load Balanced Apache

* It installs Apache on the two web servers, and configures it with a index page that identifies which host you're viewing the page on.

# Prerequisites
1.  Install [Vagrant](http://www.vagrantup.com/downloads.html) 
2.  Install kvm virtualization.
3.  Either clone this repo with ``` git clone https://github.com/jblinuxclicks/haproxy-lb-ansible-inspec.git ``` or just download the [current zip file](https://github.com/justintime/vagrant-haproxy-demo/archive/master.zip) and extract it in an empty directory.

# Getting started
1.  Open 3 terminal windows -- one for each host.  Change to the directory containing the Vagrantfile from step 3 above.
2.  In terminal #1, run ``` vagrant up haproxy --provider libvirt && vagrant ssh haproxy ```
3.  In terminal #2, run ``` vagrant up web1 --provider libvirt  && vagrant ssh web1 ```
4.  In terminal #3, run ``` vagrant up web2 --provider libvirt  && vagrant ssh web2 ```
5.  Open up [http://localhost:8080/haproxy?stats](http://localhost:8080/haproxy?stats) in your host's browser.  This is the HAProxy admin interface.
6.  Open up [http://localhost:8081/](http://localhost:8081/) in your host's browser.  This is the load balanced interface to the two web servers.  **Note** this is port forwarded via your actual host, and will be accessible via your externally accessible IP address - you can access test the load balancer from another workstation if you wish.
7.  Open up [http://172.28.33.11/](http://172.28.33.11/) in a browser to see if web1's Apache is working.
8.  Open up [http://172.28.33.12/](http://172.28.33.12/) in a browser to see if web2's Apache is working.
5.  To see the Apache access logs on web1 and web2, run ``` sudo tail -f /var/log/apache2/access.log ```  If you'd like to filter out the "pings" from the load balancer, run ``` sudo tail -f /var/log/apache2/access.log | grep -v OPTIONS ```
6.  To stop Apache on one of the webservers to simulate an outage, run ``` sudo service apache2 stop ```  To start it again, run ``` sudo service apache2 start ```

7.  To shut down the VM's, run ``` vagrant halt web1 web2 haproxy ```
8.  To remove the VM's from your hard drive, run ``` vagrant destroy web1 web2 haproxy ```
9.  If you wish to remove the cached image file from which these machines were created, run ``` vagrant box remove generic/ubuntu1804 ```


# Using ansbile playbook for provisioning
1. Once server is ready Ansible provision using to install.
2. HA Proxy in ha_proxy.
3. And apache2 in web1 and web2 servers.

# Using inspec and kitchen to verify the infra provisioning
1. Install bundler in your system.
2. Install depedencys via ```bundle install```
3. Then execute the kitchen test - it will provision the vm using vagrant and run the playbook 
4. Finally it will execute the inspec verify to check the desired state of the infra
   ```bundle exec kitchen test```

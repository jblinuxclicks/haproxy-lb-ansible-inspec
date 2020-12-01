describe package('apache2') do
  it { should be_installed }
end

control "01" do
  impact 0.7
  title "Verify apache2 service"
  desc "Ensures apache2 service is up and running"
  describe service("apache2") do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe port(80) do
 it { should be_listening }
end

# implement os dependent tests
web_user = "www-data"
web_user = "nginx" if os[:family] == "centos"

describe user(web_user) do
  it { should exist }
end
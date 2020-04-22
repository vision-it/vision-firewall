require 'spec_helper_acceptance'

describe 'vision_firewall::psad' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        exec { '/bin/grep -q 10 /etc/debian_version && /usr/bin/update-alternatives --set iptables /usr/sbin/iptables-legacy || echo stretch ':
        }

        class { 'vision_firewall::psad':
          }
      FILE

      apply_manifest(pp, catch_failures: true)
    end
  end

  context 'packages installed' do
    describe package('psad') do
      it { is_expected.to be_installed }
    end
  end

  context 'files provisioned' do
    describe file('/etc/psad/psad.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'foohost' }
      its(:content) { is_expected.to match 'foo@bar.example' }
    end
    describe file('/etc/psad/auto_dl') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match '127.0.0.1 0' }
      its(:content) { is_expected.to match '192.168.10.4 3 tcp' }
      its(:content) { is_expected.to match 'tcp/1-1024' }
    end
  end
end

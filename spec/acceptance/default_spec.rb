require 'spec_helper_acceptance'

describe 'vision_firewall' do

  context 'with defaults' do
    it 'should idempotently run' do
      pp = <<-EOS

        class { 'vision_firewall':
              }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  describe iptables do
    it { should have_rule('-A INPUT -p icmp -m comment --comment "000 accept all ICMP" -j ACCEPT') }
    it { should have_rule('-A INPUT -i lo -m comment --comment "001 accept all to lo interface" -j ACCEPT') }
    it { should have_rule('-A INPUT -d 127.0.0.0/8 ! -i lo -m comment --comment "002 reject local traffic not on loopback interface" -j REJECT --reject-with icmp-port-unreachable') }
    it { should have_rule('-A INPUT -m comment --comment "003 accept related established rules" -m state --state RELATED,ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A INPUT -p tcp -m multiport --dports 22 -m comment --comment "010 accept all SSH" -j ACCEPT') }
    it { should have_rule('-A INPUT -p tcp -m multiport --dports 25 -m comment --comment "011 accept all SMTP" -j ACCEPT') }
    it { should have_rule('-A INPUT -p tcp -m multiport --dports 80 -m comment --comment "100 allow http access" -j ACCEPT') }
    it { should have_rule('-A INPUT -p tcp -m multiport --dports 443 -m comment --comment "101 allow https access" -j ACCEPT') }
    it { should have_rule('-A INPUT -m comment --comment "999 drop all other requests" -j DROP') }
  end

end

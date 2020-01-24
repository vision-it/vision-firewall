require 'spec_helper_acceptance'

describe 'vision_firewall' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        class { 'vision_firewall':
         system_rules => {
           '101 allow https access' => {
             dport  => '443',
             proto  => 'tcp',
             action => 'accept'
            }
           }
          }
      FILE

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: false)
    end
  end

  describe iptables do
    it { is_expected.to have_rule('-A INPUT -p icmp -m comment --comment "000 accept all ICMP" -j ACCEPT') }
    it { is_expected.to have_rule('-A INPUT -i lo -m comment --comment "001 accept all to lo interface" -j ACCEPT') }
    it { is_expected.to have_rule('-A INPUT -d 127.0.0.0/8 ! -i lo -m comment --comment "002 reject local traffic not on loopback interface" -j REJECT --reject-with icmp-port-unreachable') }
    it { is_expected.to have_rule('-A INPUT -m state --state RELATED,ESTABLISHED -m comment --comment "004 accept related established rules" -j ACCEPT') }

    it { is_expected.to have_rule('-A INPUT -p tcp -m multiport --dports 443 -m comment --comment "101 allow https access" -j ACCEPT') }
    it { is_expected.to have_rule('-A INPUT -m comment --comment "999 drop all other requests" -j DROP') }
  end
end

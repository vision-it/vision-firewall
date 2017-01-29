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

  # TODO Add tests for test rules
  describe iptables do
    #it { should have_rule('-A INPUT -p tcp --dport 80 -j ACCEPT') }
    #it { should have_rule('-P INPUT ACCEPT') }
  end

end

require 'spec_helper'
require 'hiera'

describe 'vision_firewall::forward' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      # Just so that $title is set to something
      let(:title) {{
                      :name    => '400 foobar',
                    }}

      let(:params) {{
                      :rule_name    => '400 foobar',
                      :ipaddress    => '1.2.3.4',
                      :dom0hostname => 'foohost',
                      :dom0ip       => '4.3.2.1',
                      :sourceip     => '1.1.1.1/24',
                      :dport        => '1234',

                    }}

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'params' do
        it { is_expected.to contain_firewall('400 foobar').with(
                              'tag'         => 'foohost',
                              'chain'       => 'PREROUTING',
                              'table'       => 'nat',
                              'proto'       => 'tcp',
                              'iniface'     => 'eth0',
                              'source'      => '1.1.1.1/24',
                              'destination' => '4.3.2.1',
                              'jump'        => 'DNAT',
                              'dport'       => '1234',
                              'todest'      => '1.2.3.4:1234',
                            )}
      end

    end
  end
end

describe 'vision_firewall::forward' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      # Just so that $title is set to something
      let(:title) {{
                      :name    => '400 foobar',
                    }}

      let(:params) {{
                      :rule_name    => '400 foobar',
                      :ipaddress    => '1.2.3.4',
                      :dom0hostname => 'foohost',
                      :dom0ip       => '4.3.2.1',
                      :dport        => '1234',
                    }}


      context 'params' do
        it { is_expected.to contain_firewall('400 foobar').with(
                              'tag'         => 'foohost',
                              'chain'       => 'PREROUTING',
                              'table'       => 'nat',
                              'proto'       => 'tcp',
                              'iniface'     => 'eth0',
                              'destination' => '4.3.2.1',
                              'jump'        => 'DNAT',
                              'dport'       => '1234',
                              'todest'      => '1.2.3.4:1234',
                            )}
      end

    end
  end
end

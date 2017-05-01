require 'spec_helper'
require 'hiera'

describe 'vision_firewall' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      # Export a firewall resource
      context 'exported resources' do
        it { expect(exported_resources).to contain_firewall('100 allow http access') }
      end

      # Plain old resource
      context 'createed resources' do
        it { is_expected.to contain_firewall('101 allow https access') }
      end
    end
  end
end

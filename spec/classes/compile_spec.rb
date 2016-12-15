require 'spec_helper'
require 'hiera'

describe 'vision_firewall' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {{
                      :location  => 'intVm',
                    }}

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'exported resources' do
        it { expect(exported_resources).to contain_vision_firewall__forward('400 foobar') }
        it { expect(exported_resources).to contain_vision_firewall__forward('410 barfoo') }
      end

    end
  end
end


describe 'vision_firewall' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {{
                      :location  => 'something',
                    }}

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'no exported resources' do
        it { expect(exported_resources).not_to contain_vision_firewall__forward('400 foobar') }
      end

    end
  end
end


describe 'vision_firewall' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {{
                      :location       => 'something',
                      :forward_rules  => {},
                    }}

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'no exported resources' do
        it { expect(exported_resources).not_to contain_vision_firewall__forward('400 foobar') }
      end

    end
  end
end

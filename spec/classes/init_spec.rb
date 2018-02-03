require 'spec_helper'
describe 'windows_domain_controller' do
  context 'with domain specified as readonly' do
    let(:params) do
      { :domain => 'readonly' }
    end

    it { should contain_class('windows_domain_controller') }
    it { should contain_class('windows_domain_controller::rodc') }
  end
end

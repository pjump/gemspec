require 'spec_helper'

describe 'Spec' do
  it 'satisfies a tautological expectation' do
    expect(true).to be_truthy
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end

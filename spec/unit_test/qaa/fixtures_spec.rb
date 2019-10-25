require 'spec_helper'

describe Qaa::Fixtures do
  it 'has a version number' do
    expect(Qaa::Fixtures::VERSION).not_to be nil
  end

  it 'should be a singleton' do
    fixture1 = Qaa::Fixtures.instance
    fixture2 = Qaa::Fixtures.instance
    expect(fixture1).to equal(fixture2)
    expect{fixture2.dup}.to raise_error
  end

  it 'should call configuration' do
   expect(Qaa::Configuration).to receive(:fetch).with("key_test",'')
    Qaa::Fixtures.instance["key_test"]
  end

end

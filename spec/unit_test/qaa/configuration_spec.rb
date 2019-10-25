require 'spec_helper'
require 'qaa/configuration'


describe Qaa::Configuration do

  it 'should have a default empty config' do
    expect(Qaa::Configuration.config).to be_eql({})
  end

  it 'should return empty value for not found key' do
    expect(Qaa::Configuration.fetch('not_real_key')).to be_eql ''
  end

  describe 'when I load a config file' do
    before(:all) do
      Qaa::Configuration.load 'profile.test', "#{File.dirname(__FILE__) + '/../../fixtures/config.yml'}"
    end

    it 'should have config data' do
      expect(Qaa::Configuration.config).to_not be_empty
    end

    it 'should fetch a key' do
      expect(Qaa::Configuration.fetch('namespace')).to be_eql 'test'
      expect(Qaa::Configuration.fetch('foo.unknown_key')).to be_empty
    end

    it 'should check key existence' do
      expect(Qaa::Configuration.has_key?('namespace')).to be_eql true
      expect(Qaa::Configuration.has_key?('unknown_key')).to be_eql false
    end

    describe 'when I add a second file' do
      before(:all) do
        Qaa::Configuration.load 'profile.test', "#{File.dirname(__FILE__) + '/../../fixtures/bob_config.yml'}"
      end


      it 'should return a key from the second file' do
        expect(Qaa::Configuration.fetch('bob')).to be_eql 'bob_test'
      end

      it 'should merge a second file' do
        expect(Qaa::Configuration.fetch('bob')).to be_eql 'bob_test'
        expect(Qaa::Configuration.fetch('namespace')).to be_eql 'test'
      end

      it 'should throw an error on wrong file' do
        expect { Qaa::Configuration.load 'profile.test', "#{File.dirname(__FILE__) + '/../../fixtures/unknown_config.yml'}" }.to raise_error
      end

      it 'should not loose the configuration on error' do
        Qaa::Configuration.load 'profile.test', "#{File.dirname(__FILE__) + '/../../fixtures/unknown_config.yml'}" rescue nil
        expect(Qaa::Configuration.fetch('bob')).to be_eql 'bob_test'
      end

      it 'should deep merge the yaml file' do
        expect(Qaa::Configuration.fetch('foo.baz')).to be_eql 'baz_test'
        expect(Qaa::Configuration.fetch('foo.baz2')).to be_eql 'bob_baz2'
        expect(Qaa::Configuration.fetch('foo.baz3')).to be_eql 'bob_baz3'
      end


      describe 'when I reset the configuration' do
        before(:all) do
          Qaa::Configuration.load 'profile.live', "#{File.dirname(__FILE__) + '/../../fixtures/config.yml'}", true
        end

        it 'should return a key from the first file' do
          expect(Qaa::Configuration.fetch('namespace')).to be_eql 'live'
        end

        it 'should not return a key from the second file' do
          expect(Qaa::Configuration.fetch('bob')).to_not be_eql 'bob_test'
        end

      end
    end
  end


end

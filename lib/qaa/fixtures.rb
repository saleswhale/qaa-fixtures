# encoding: utf-8
require "qaa/fixtures/version"
require 'qaa/configuration'
require 'singleton'

module Qaa
  class Fixtures
    include Singleton

    def self.instance
      @instance ||= new
    end

    def [] (fixture_name)
      sym = fixture_name.to_sym
      Configuration.fetch("#{sym}", '')
    end
  end
end

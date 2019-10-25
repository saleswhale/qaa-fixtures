require 'simplecov'
require 'simplecov-teamcity-summary/formatter'
SimpleCov.start do
  at_exit do
    SimpleCov::Formatter::TeamcitySummaryFormatter.new.format(SimpleCov.result) if ENV['TEAMCITY_VERSION']
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qaa/fixtures'



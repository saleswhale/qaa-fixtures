# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qaa/fixtures/version'

Gem::Specification.new do |spec|
  spec.name          = "qaa-fixtures"
  spec.version       = Qaa::Fixtures::VERSION
  spec.authors       = ["khoahong"]
  spec.email         = ["hongakhoa@gmail.com"]
  spec.summary       = %q{get fixtures from yml file}
  spec.description   = "get fixtures from yml file. Can get multiple files and merge them"
  spec.homepage      = "https://bitbucket.org/lazadaweb/qaa-fixtures"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://geminabox.lzd.co"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  ignores  = File.readlines(".gitignore").grep(/\S+/).map(&:chomp)
  dot_files = %w[.gitignore]

  all_files_without_ignores = Dir["**/*"].reject { |f|
    File.directory?(f) || ignores.any? { |i| File.fnmatch(i, f) }
  }

  spec.files = (all_files_without_ignores + dot_files).sort
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
end

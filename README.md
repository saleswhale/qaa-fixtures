# Qaa::Fixtures
Fixtures allow deep merge for reading yml files

## Installation

Add this line to your application's Gemfile from lazada gem repo:

```ruby
gem 'qaa-fixtures'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qaa-fixtures

## Usage

Load gem :

```ruby
require 'qaa/fixtures'
require 'qaa/configuration'
```


Load yml file :

```ruby
Qaa::Configuration.load(PROFILE, "#{PROJECT_DIR}/config/config.yml")
```


Fetch a value :

```ruby
Qaa::Fixtures.instance['currency']
```


If you want to avoid to put Qaa before each put in your `spec_helper.rb` or/and `env.rb` :

```ruby
include Qaa
```

##Version
1.0.1: moving unit_test under unit_test folder
# Mongoid::Suicide

[![Build Status][travis_badge]][travis]
[![Gem Version][rubygems_badge]][rubygems]
[![Code Climate][codeclimate_badge]][codeclimate]

Provides methods to remove fields from Mongoid models

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid-suicide'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-suicide

## Usage

Set up a `Mongoid::Suicide`:

```ruby
class Person
  include Mongoid::Document
  include Mongoid::Suicide

  field :username, type: String
end

p = Person.first
p.username
=> ...
```

Remove a field from a document:

```ruby
Person.remove_field(:username)

p = Person.first
p.username
=> NoMethodError: undefined method `username'
```

## Contributing

1. Fork it ( https://github.com/mamantoha/mongoid-suicide/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License and Author

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright (c) 2015-2017 by Anton Maminov

[travis_badge]: http://img.shields.io/travis/mamantoha/mongoid-suicide.svg?style=flat
[travis]: https://travis-ci.org/mamantoha/mongoid-suicide

[rubygems_badge]: http://img.shields.io/gem/v/mongoid-suicide.svg?style=flat
[rubygems]: http://rubygems.org/gems/mongoid-suicide

[codeclimate_badge]: http://img.shields.io/codeclimate/github/mamantoha/mongoid-suicide.svg?style=flat
[codeclimate]: https://codeclimate.com/github/mamantoha/mongoid-suicide

# agnostic_slugs

agnostic_slugs is a simple slug generator that is agnostic.

What it can:
* Generate slugs

What it can not:
* Integrate with ActiveRecord, Mongoid or any other ORM
* Integrate with Rails or any other framework
* Monkey-patch the `String` class

## Status

[![Build Status](https://semaphoreapp.com/api/v1/projects/29d6a477-42c2-450a-b261-937cc7497806/298877/badge.png)](https://semaphoreapp.com/lasseebert/agnostic_slugs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agnostic_slugs'
```

## Usage

```ruby
slug = AgnosticSlugs::Slug.new('Look at my pretty new shoes! :)')
slug.to_s       # => "look-at-my-pretty-new-shoes"
slug.next.to_s  # => "look-at-my-pretty-new-shoes-2"
```

Or step through slugs to find a unique slug using your own business logic:

```ruby
AgnosticSlugs::Slug.step('Hello world') do |slug|
  my_repo.slug_unique?(slug)
end
# => "hello-world-7"
```

## Contributing

1. Fork it ( https://github.com/lasseebert/agnostic_slugs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# AgnosticSlugs

agnostic_slugs is a simple slug generator that is agnostic.

* It does not care about ORMs.
* It will not monkey patch

It can create slugs. Period.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agnostic_slugs'
```

## Usage

    slug = AgnosticSlug::Slug.new('Look at my pretty new shoes! :)')
    slug.to_s       # => "look-at-my-pretty-new-shoes"
    slug.next.to_s  # => "look-at-my-pretty-new-shows-2"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/agnostic_slugs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

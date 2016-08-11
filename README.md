# Rack::BanExtension

Rack middleware to reject any URL request ending with a specified extension. e.g. `.php`

Ideally you would implement this type of filtering directly in nginx or apache, however some hosting providers do not allow this configuration.

Banning an extension will return an empty 400 response code instead of hitting your application and returning a 404.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-ban_extension', github: 'marcom-unimelb/rack-ban_extension'
```

And then execute:

    $ bundle

## Usage

Include the middleware and provide an array of extensions to reject.

Ruby on Rails example (application.rb):

    config.middleware.use Rack::BanExtension, %w(php aspx)

This configuration will block requests to:

    /index.php
    /index.PHP
    /index.aspx
    /page.php?param=value
    /page.php#anchor

It will **not** block requests to:

    /
    /index
    /index?.php
    /index#.php
    /page.php3
    /page.asp

The exact extension name must be used. You may want to include common variations of an extension to catch more URLs:

    use Rack::BanExtension, %w(php php3 asp aspx)

## See also

As an alternative you might want to investigate these similar gems which were an influence on this project:

* [rack-attack](https://github.com/kickstarter/rack-attack)
* [rack-accept](https://github.com/mjackson/rack-accept)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcom-unimelb/rack-ban_extension. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

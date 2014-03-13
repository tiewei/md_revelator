# Md::Revelator

Generated reveal.js based web presentations from markdown

## Installation

Add this line to your application's Gemfile:

    gem 'md_revelator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install md_revelator

## Usage

`chmod +x bin/md2reveal`

`md2reveal <your-markdown-file> <output-folder>`

Or

```ruby

require "md_revelator"

Md::Revelator.reveal!(md\_file, output\_folder)

```

**Version 1**

Currently **only** support `v1` - using `\n===\n\n` or `\n+++\n\n` to separate slides, the first silde contains metadata


**Version 2**

Trying to implement a Redcarpet::Render to support full content generation


## DEMO

The simple input could be found in test/slide.md

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

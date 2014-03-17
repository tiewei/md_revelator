# Md::Revelator

Generated reveal.js based web slides from markdown, generated web slides like <http://lab.hakim.se/reveal-js/#/>

## Installation

Add this line to your application's Gemfile:

    gem 'md_revelator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install md_revelator

## Version

There are 2 kinds of method we translate markdown file into slides, we called it version. Each version has some special function.

**Version 1** 

  In this version , we use 3 or more "=" or "+" to separate slides, metadata could be setted in the first slide in "k:v"

  This version supports **vertical slides** by using different separation, you could find example in test/slide-v1.md

  You could find the codes in `simple_revelator.rb` 

  *NOTE* - This version doesn't support "fragment"

**Version 2**

  In the version 2, we use `redcarpet` to convers markdown file into html, we rewrite the render in order to fit `reveal.js`,
we use markdown tags which would be translate into `<br/>` to separate slides, 
and metadata could be setted at the head of the markdown file in **YAML** way - start with `---\n` and end with `---\n`

This version supports **fragment** in markdown "head" "list item" and "paragraph", every raw markdown tag start with `$<style><space>` (eg. `$grow `) will be treat as a "fragment". style must be in [ "", "grow", "shrink", "roll-in", "fade-out", "current-visible",
"highlight-red", "highlight-blue", "highlight-green", "highlight-current-blue", "highlight-current-green","highlight-current-red"],
if you don't know which to use, leave it alone will always be right.

  The example input could be found in test/slide-v2.md

  You could find the customlized render in `reveal_render.rb`

  *NOTE* - This version doesn't support "vertical slides"

## Metadata

Metadata is the configuration of the slides will be. Supported metadata as list:

* Key => "default value" => (options) => descrition

* `theme` => "default"  => (beige sky simple serif night default blood moon solarized) => theme of the slides
* `transition` => "default" => (default cube page concave zoom linear fade none) => transition style between slides
* `autoSlide` => 0 => (equal or larger than 0) => If large than 0, the slides will be auto play every {value} millisecond
* `transitionSpeed` => 'default'=> (default fast slow) => the speed of slide transition
* `backgroundTransition` => 'default'=> (default none slide concave convex zoom) => the style of background transition
* `ref` => 'cdn' => (local, cdn) => if is local `reveal.js` lib will be copy to output directory, else goto cdn
* `title` => 'Presentations generated from markdown by md-revelator' => no check => the title of the slides in html head
* `author` =>  ENV["USER"] => no check => the author of the slides in html head
* `description` => '' => no check => the description of the slides in html head
* `cdn` => <http://cdn.staticfile.org/reveal.js/2.6/> => no check => the cdn host for `reveal.js`

## Usage

**CLI**

`chmod +x bin/md2reveal`

`md2reveal <your-markdown-file> <output-folder> <version>`

**ruby**

```ruby

require "md_revelator"

Md::Revelator.reveal!(md_file, output_folder, version)

```


## DEMO

The simple input could be found in test/

clone the project and try

```
bin/md2reveal test/slide-v1.md test/output/ 1

bin/md2reveal test/slide-v2.md test/output/ 2
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

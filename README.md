# ParamsParser

`ParamsParser` is a simple gem to help - you guessed it - parse parameter hashes.

`ParamsParser` currently supports:

* defaults
* transformations
* mapping input keys to output keys


## Installation

Add this line to your application's Gemfile:

    gem 'params_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install params_parser

## Usage

Create a parser with a configuration hash:

```ruby
parser = ParamsParser::Parser.new({
  id: { transform: Model.public_method(:find), map_to: :model }
  page: { default: 1, transform: :to_i.to_proc }
})
```

Parse parameters:

```ruby
parser.parse({        # {
  id: "1",            #   model: Model(...),
  page: "5"           #   page: 5
})                    # }
```

```ruby
parser.parse({        # {
  id: "1",            #   model: Model(...),           
})                    #   page: 1
                      # }
```

## Contributing

1. Fork it ( http://github.com/gustly/params_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

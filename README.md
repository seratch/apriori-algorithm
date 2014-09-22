# Apriori::Algorithm

[Apriori Algorithm](http://en.wikipedia.org/wiki/Apriori_algorithm) Ruby implementation which is based on https://github.com/asaini/Apriori/blob/master/apriori.py.

## Installation

[![Gem Version](https://badge.fury.io/rb/apriori-algorithm.svg)](http://badge.fury.io/rb/apriori-algorithm)

[![Build Status](https://travis-ci.org/seratch/apriori-algorithm.svg)](https://travis-ci.org/seratch/apriori-algorithm)

Add this line to your application's Gemfile:

```ruby
gem 'apriori-algorithm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apriori-algorithm

## Usage

See also: spec/usage_spec.rb

    require 'apriori/algorithm'
    algorithm = Apriori::Algorithm.new()
    #algorithm = Apriori::Algorithm.new(0.15, 0.8)
    
    result = algorithm.analyze(transactions)
    result.frequent_item_sets
    result.association_rules

## License

The MIT License

Copyright (c) 2014 Kazuhiro Sera

## Contributing

1. Fork it ( https://github.com/[my-github-username]/apriori-algorithm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Mintkit

A Mint.com API.  Not at all affiliated with or endorsed by mint.com/intuit.  Your mileage may vary.

This is currently not being maintained. I will circle back when I have a chance, but in the meantime try out 
https://github.com/mattdbridges/minty

## Installation

Add this line to your application's Gemfile:

    gem 'mintkit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mintkit

## Usage

Command line: 

``` shell
mintkit --help
```

Ruby API: 

```ruby
client = Mintkit::Client.new(username,password)

# tell mint to refresh all your accounts
client.refresh             #(note: it doesn't block yet while refreshing)

# dump all accounts and transactions
puts client.accounts       #print out the accounts
puts client.transactions   #print out all your transactions

# or use iterators (works for accounts as well)
client.transactions do |t|
   puts "#{t[:account]} #{t[:amount]} #{t[:description]} #{t[:date]}"
end

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Mintkit

A Mint.com API.  Not at all affialiated with or endorsed by mint.com/intuit.  Your mileage may vary.

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

# refresh your account
client.refresh             #refresh the accounts

# dump all accounts and transactions
puts client.accounts       #print out the accounts
puts client.transactions   #print out all your transactions

# or use iteratorst
client.transactions do |t|
   puts "#{t[:account]} #{t[:amount]} #{t[:description]} #t{t[:date]}"
do
end

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

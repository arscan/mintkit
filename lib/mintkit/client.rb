require "selenium-webdriver"
module Mintkit

  class Client

    def initalize(options={})

      # do the options
      @username = options.username
      @password = options.password
      @mint_url = options.mint_url

      @driver = Selenium::Webdriver.for :firefox

    end

    # login to my account
    def login

      @driver.navigate.to @mint_url

      puts @driver.title

    end
    # get all the transactions
    def transactions(startdate)
      
    end

    # force a refresh on my account
    def refresh
      
    end
  end
end

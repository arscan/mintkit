require "mechanize"
module Mintkit

  class Client

    def initialize(username, password)

      @username = username
      @password = password

      @agent = Mechanize.new
    end

    # login to my account
    def login
      page = @agent.get('https://wwws.mint.com/login.event')
      form = page.forms[2]
      form.username = @username
      form.password = @password
      @agent.submit(form,form.buttons.first)
      return

    end
    # get all the transactions
    def transactions
      raw_transactions = @agent.get("https://wwws.mint.com/transactionDownload.event?").body

      transos = []

      raw_transactions.split("\n").each_with_index do |line,index|

        if index > 1
          line_array = line.split(",")
          transaction = {
            :date => Date.strptime(remove_quotes(line_array[0]), '%m/%d/%Y'),
            :description=>remove_quotes(line_array[1]),
            :original_description=>remove_quotes(line_array[2]),
            :amount=>remove_quotes(line_array[3]).to_f,
            :type=>remove_quotes(line_array[4]),
            :category=>remove_quotes(line_array[5]),
            :account=>remove_quotes(line_array[6]),
            :labels=>remove_quotes(line_array[7]),
            :notes=>remove_quotes(line_array[8])
          }
          transos << transaction

        end

        
      end
      transos
      
    end

    def logout

    end

    # force a refresh on my account
    def refresh
      
    end

  private
    def remove_quotes(input)
        input.slice(1..-1).slice(0..-2)
    end

  end
end

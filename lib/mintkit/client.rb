require "mechanize"
require "json"

module Mintkit

  class Client

    def initialize(username, password)

      @username = username
      @password = password
      @token = nil

    end

    # login to my account
    # get all the transactions
    def transactions
      agent = login
      raw_transactions = agent.get("https://wwws.mint.com/transactionDownload.event?").body

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
      logout(agent)
      transos
      
    end

    def accounts
      agent = login
      page = agent.get('https://wwws.mint.com/overview.event')


      requeststring = %q#[{"args":{"types":["BANK","CREDIT","INVESTMENT","LOAN","MORTGAGE","OTHER_PROPERTY","REAL_ESTATE","VEHICLE","UNCLASSIFIED"]},"service":"MintAccountService","task":"getAccountsSortedByBalanceDescending","id":"8675309"}]#

      accounts = JSON.parse(agent.post("https://wwws.mint.com/bundledServiceController.xevent?token=#{@token}",{"input" => requeststring}).body)["response"]["8675309"]["response"]

      logout(agent)
 
      accounts

    end

    # force a refresh on my account
    def refresh
      agent = login
      page = agent.get('https://wwws.mint.com/overview.event')

      agent.post("https://wwws.mint.com/refreshFILogins.xevent", {"token"=>@token})

      logout(agent)

      true
      
    end
  private

    def login

      agent = Mechanize.new{|a| a.ssl_version, a.verify_mode = 'SSLv3', OpenSSL::SSL::VERIFY_NONE}
      page = agent.get('https://wwws.mint.com/login.event')
      form = page.forms[2]
      form.username = @username
      form.password = @password
      page = agent.submit(form,form.buttons.first)
      @token = page.at('input').attributes["value"].value.match(/"token":"([0-9a-zA-Z]*)"/)[1]
      agent

    end

    def logout(agent)
      agent.get('https://wwws.mint.com/logout.event?task=explicit')
      true
    end


  private
    def remove_quotes(input)
        input.slice(1..-1).slice(0..-2)
    end

  end
end

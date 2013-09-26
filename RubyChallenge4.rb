require 'spreadsheet'
require_relative 'portfolio'

def portfolioExistError(code)
  if code == 0
    puts ""
    puts "*****************************************************"
    puts "WARNING!!!"
    puts "A portfolio with this name already exists."
    puts "You must pick another name for your portfolio."
    puts "*****************************************************"
    puts ""
  elsif code == 1
    puts "*****************************************************"
    puts "WARNING!!!"
    puts "A portfolio with this name does NOT exist."
    puts "You must pick another name for your portfolio."
    puts "*****************************************************"
    puts ""
  else
    puts "Exception....bad value passed to portfolioExistError"
  end

end

begin
  puts "What is your last name?"
  lastName = gets.chomp.downcase
  #puts lastName
  puts ""

  begin
    portfolio = Portfolio.new

    portExist = portfolio.portfolioExist(lastName)
    puts ""
    puts "What do you want to do? (Enter a number)"
    puts "1.  Create A New Portfolio"
    puts "2.  View One Year Summary"
    puts "3.  Change My Current Allocations"
    puts "4.  Calculate End Of Year"
    puts "5.  Summary Report"
    puts "6.  Exit"
    puts ""
    choice = gets.chomp.to_i

    case choice
      when 1
        puts ""
        if portExist == true
          portfolioExistError(0)
        else
          portfolio.init_portfolio(lastName)    #create a new portfolio
          puts ""
          portfolio.publishYear(lastName,1,0) #0 means include header row
        end
      when 2
        if portExist == false
          portfolioExistError(1)
        else
          puts "What year do you want to see your portfolio from?"
          yearNum = gets.chomp.to_i
          puts ""
          portfolio.publishYear(lastName,yearNum,0) #0 means include header row
        end

      when 3
        if portExist == false
          portfolioExistError(1)
        else
          portfolio.reallocateCurrentYear(lastName)
        end
      when 4
        if portExist == false
          portfolioExistError(1)
        else
          portfolio.calculateYear(lastName)
        end
      when 5
        if portExist == false
          portfolioExistError(1)
        else
          portfolio.publishSummary (lastName)
        end
      when 6
        puts ""
        puts "Later...."
      else
        puts ""
        puts "Invalid entry!"
    end

    puts ""
    puts "Hit Enter key to continue..."
    gets

  end until choice == 6

end












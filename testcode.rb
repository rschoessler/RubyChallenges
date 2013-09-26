require 'spreadsheet'
require_relative 'portfolio'

puts "What is your last name"
lastName = gets.chomp
#puts lastName

puts "What year do you want to see your portfolio from?"
yearNum = gets.chomp.to_i
#puts yearNum

portfolio = Portfolio.new
portfolio.publish(yearNum,lastName)






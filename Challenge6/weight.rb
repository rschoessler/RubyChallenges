#this is the main file for this challenge


#ok, let's prompt the user for an amount of grain

puts "How much grain do you have? (between 1 and 40 pounds)"
grainWeight = gets.chomp.to_i

if grainWeight > 40 or grainWeight < 1
  puts "I can only measure weights between 1 and 40 pounds!"
end

puts grainWeight


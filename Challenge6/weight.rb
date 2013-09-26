require_relative "balance"

#this is the main file for this challenge


#ok, let's prompt the user for an amount of grain

$non_grain_side = 0    #sets the initial value of the weight on the grain side of the balance
$grain_side = 0         #sets the initial value of the grain side of the balance

puts "How much grain do you have? (between 1 and 40 pounds)"
grainWeight = gets.chomp.to_i

if grainWeight > 40 or grainWeight < 1
  puts "I can only measure weights between 1 and 40 pounds!"
end

#puts grainWeight

balance = Balance.new
$grain_side = balance.addToGrainSide(grainWeight,$grain_side)

puts "You now have #{$grain_side} pounds of grain on the scale."

arrayBalance = balance.calculate($grain_side, $non_grain_side)

puts arrayBalance[:grain]     #an array in a hash
puts arrayBalance[:non_grain] #an array in a hash


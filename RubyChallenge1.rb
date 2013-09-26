num = 1 #while this is equal to 1, do another test
begin                       #this will do a test until num = 0
  #randomly generate a number between 0 and 12

  countCorrect = 0 #set this to 0 for starters
  countWrong = 0  #set this to 0 for starters

  10.times do |i|
    x = Random.new.rand(0..12)
    y = Random.new.rand(0..12)

    #Ask the question
    puts "Question (#{i+1}):"
    puts "#{x} x #{y} = ??? "
    useranswer = gets.chomp
    useranswer = useranswer.to_i
    answer = x * y

    if useranswer != answer
      countWrong = countWrong + 1
      puts "Incorrect!"
    else
      countCorrect = countCorrect + 1
      puts "Correct!"
    end

    puts "You answered -#{useranswer}-"
    puts "The product of #{x} and #{y} is: #{x*y}"
    puts "Correct:  #{countCorrect}"
    puts "Incorrect:  #{countWrong}"
  end

  puts ""

  finalscore = (countCorrect*100)/(countCorrect + countWrong)

  puts "Your score was #{finalscore}."

  if finalscore == 100
    puts "Bob will be very proud of you!"
  elsif finalscore >= 90 and finalscore < 100
    puts "Nice score...we expect better though..."
  elsif finalscore >= 70 and finalscore < 90
    puts "Needs a lot of work...consider talking to Bert about Python"
  else
    puts "Ever consider manual labor?"
  end

  puts "Would you like to try again? (Yes or No)?"
  again = gets.chomp.downcase

  if again == "yes"
    #do nothing
  elsif again == "no"
    num = 0
  else
    puts "You didn't enter a valid value, therefore you must do this again!"
  end

end until num == 0

puts ""
puts "Thanks for playing!!"



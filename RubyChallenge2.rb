def evalAnswer (answer)
  #use a regex to evaluate the string to make sure that it is a number
   test = answer.scan (/\d/)            #create an array of numbers returned in the string

   answerlength = answer.length
   testlength = test.length
   #puts "Answer Length:  #{answerlength}"
   #puts "Test Length:  #{testlength}"


  if testlength != answerlength
    puts "You must enter an integer!"
    return  FALSE
  else
    puts "You have input an integer"
    return TRUE
  end

end

def getRandomNum ()
  #first, create a random number between 1 and 4
  intRand = Random.new.rand(1..4)
  if intRand == 1          #if the value is 1 then return either 7 or 8
    intRandReturn = Random.new.rand(7..8)
  else
    #otherwise, just let it pick randomly
    intRandReturn = Random.new.rand(0..12)
  end
  return intRandReturn
end

num = 1 #while this is equal to 1, do another test

begin                       #this will do a test until num = 0
  #randomly generate a number between 0 and 12

  countCorrect = 0 #set this to 0 for starters
  countWrong = 0  #set this to 0 for starters

  10.times do |i|
    x = getRandomNum
    y = getRandomNum

    begin
      #Ask the question
      puts ""
      puts "Question (#{i+1}):"
      puts "#{x} x #{y} = ??? "
      useranswer = gets.chomp
      #puts evalAnswer(useranswer)
    end until evalAnswer(useranswer) == true


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



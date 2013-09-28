#the correct combination of weights is 1-3-9-27
#the trick is that you need to add weight to both sides of the scales at times
#see rubychallenge_6_farmer_rock.xlsx for combinations

#observations
#you never subtract 27
#you only add 27 starting with number 14
#from 14 and up to 22, you subtract 9

class Balance
  ROCK1 = 1
  ROCK3 = 3
  ROCK9 = 9
  ROCK27 = 27

    def initialize
           #do nothing
    end

    def addToGrainSide(weightToAdd,grain_side)
      grain_side = grain_side +  weightToAdd
      return grain_side
    end

    def addTwoDigitsFromArray(arrayWeight,targetWeight)
      #Add all 2 digits combos until sum = targetWeight
      #return array of values used
      #use array.combination to get the combinations
      #use array.inject to add them up
      #skip over the combination where the two numbers are equal
      puts "now in addTwoDigitsFromArray "
      sum = 0
      arrayCombo = Array.new
      arrayCombo = arrayWeight.combination(2).to_a
      arraySum = Array.new
      #puts arrayCombo[0]
      i=0
      @total = 0
      puts "Target Weight: #{targetWeight}"

      begin
        arrayLength = arrayCombo.length
        puts arrayLength
        arrayCombo[i].each_slice(1) do |x,y|
          @total = arrayCombo[0].inject(:+)
        puts "Total = #{@total}"
          if @total == targetWeight
            exit
          end
          i = i + 1
          puts "i = #{i}"
        end
      end



      puts "leaving addTwoDigitsFromArray"

    end

    def addThreeDigitsFromArray(arrayWeight,targetWeight)
      #Add all 3 digits combos until sum = targetWeight
    end

    def addFourDigitsFromArray(arrayWeight,targetWeight)
      #Add all 4 digits combos until sum = targetWeight
      #return array of values used

    end


    def calculate(grain_side, non_grain_side)
      #this is the algorithm to determine which weights go on which sides of the balance
      #it should return the grain side and the non-grain side as a hash

      arrayGrain = Array.new
      arrayNonGrain = Array.new
      arrayWeights = Array.new
      arrayWeights = [ROCK1,ROCK3,ROCK9,ROCK27]
      targetWeight = grain_side

      puts "Target Weight: #{targetWeight}"

      #First, let's add all four values in the array and see if that gets us our answer
      sum = arrayWeights.inject{|sum,x| sum + x}
      #puts sum
      if grain_side == sum
        arrayNonGrain << arrayWeights #return all weights
        non_grain_side += sum
        difference = grain_side - non_grain_side
      end

      begin
      if difference != 0
        #skip this if difference ==0
         #Next, let's get the easy ones out of the way
        if grain_side - ROCK27 == 0
          arrayNonGrain << ROCK27 #we used 27 already
          non_grain_side += ROCK27
          difference = grain_side - non_grain_side
          elsif grain_side - ROCK9 == 0
            arrayNonGrain << ROCK9 #we used 9 already
            non_grain_side += ROCK9
            difference = grain_side - non_grain_side
          elsif grain_side - ROCK3 == 0
            arrayNonGrain << ROCK3 #we used 3 already
            non_grain_side += ROCK3
            difference = grain_side - non_grain_side
          elsif grain_side - ROCK1 == 0
            arrayNonGrain << ROCK1 #we used 1 already
            non_grain_side += ROCK1
            difference = grain_side - non_grain_side
          end
      end

      begin
        if difference != 0
          #Next, lets' get all of the ones that do not require weights added to both sides
          sumTwoDigits = addTwoDigitsFromArray(arrayWeights,targetWeight)
          puts sumTwoDigits
        end


      end




      if difference != 0      #skip this if difference == 0
        if grain_side - ROCK27 > 0
          arrayNonGrain << ROCK27 #we used 27 already
          non_grain_side += ROCK27
          difference = grain_side - non_grain_side

          if difference - ROCK9 > 0
            arrayNonGrain << ROCK9 #we used 9 already
            non_grain_side += ROCK9
            difference = grain_side - non_grain_side

            if difference - ROCK3 >= 0
              arrayNonGrain << ROCK3 #we used 3 already
              non_grain_side += ROCK3
              difference = grain_side - non_grain_side
                elsif difference - ROCK1  == 0
                  arrayNonGrain << ROCK1 #we used 3 already
                  non_grain_side += ROCK1
                  difference = grain_side - non_grain_side
                if difference - ROCK3 < 0
                  arrayNonGrain << ROCK3 #we used 1 already
                  non_grain_side += ROCK3
                  difference = grain_side - non_grain_side
                  elsif difference - ROCK1 < 0  #add 1 in this case to the other side
                    arrayNonGrain << ROCK1 #we used 1 already
                    non_grain_side += ROCK1
                    difference = grain_side - non_grain_side
                end
            end
            if difference - ROCK1 == 0
              arrayNonGrain << ROCK1 #we used 1 already
              non_grain_side += ROCK1
              difference = grain_side - non_grain_side
            end
          end
        end
      end
    end until difference == 0





        #puts "Non-grain side:  #{non_grain_side}"
        #puts "Grain side:  #{grain_side}"
        puts "Difference:  #{difference}"

        #arrayGrain << grain_side
        #arrayNonGrain << non_grain_side

      return {:grain => arrayGrain, :non_grain => arrayNonGrain}

    end



end
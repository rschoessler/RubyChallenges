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

    def addToNonGrain(weightToAdd,non_grain_side)

    end

    def addToGrainSide(weightToAdd,grain_side)
      grain_side = grain_side +  weightToAdd
      return grain_side
    end

    def calculate(grain_side, non_grain_side)
      #this is the algorithm to determine which weights go on which sides of the balance
      #it should return the grain side and the non-grain side as a hash

      arrayGrain = Array.new
      arrayNonGrain = Array.new


      begin
         #First, let's get the easy ones out of the way
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




      if difference != 0
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
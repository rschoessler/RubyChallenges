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


=begin
      begin
        if grain_side == 1
         #add the 1 to the non-grain side
          non_grain_side += ROCK1
          difference = non_grain_side - grain_side
        elsif grain_side > 13
          #add 27 to the non-grain side
          non_grain_side += ROCK27
          difference = non_grain_side - grain_side
        elsif grain_side == 13
          #add 9 to the grain side
          grain_side += ROCK9
          difference = non_grain_side - grain_side
        elsif grain_side < 13
          #


        end
=end

      begin
        if grain_side == 1
          #add 1 to the non-grain side
          non_grain_side += ROCK1
          difference = non_grain_side - grain_side
        end






        puts "Non-grain side:  #{non_grain_side}"
        puts "Grain side:  #{grain_side}"
        puts "Difference:  #{difference}"

        arrayGrain << grain_side
        arrayNonGrain << non_grain_side
      end until difference == 0



      return {:grain => arrayGrain, :non_grain => arrayNonGrain}

    end



end
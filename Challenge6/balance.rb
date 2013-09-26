#the correct combination of weights is 1-3-9-27
#the trick is that you need to add weight to both sides of the scales at times
#see rubychallenge_6_farmer_rock.xlsx for combinations

#observations
#you never subtract 27
#you only add 27 starting with number 14
#from 14 and up to 22, you subtract 9

class Balance

    def initialize
      @rock1 = 1
      @rock3 = 3
      @rock9 = 9
      @rock27 = 27
    end



end
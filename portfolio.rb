require "spreadsheet"
require "fileutils"

Spreadsheet.client_encoding = 'UTF-8'
#Spreadsheet.client_encoding = 'UTF-16LE'

class Portfolio

        def initialize
          #do nothing
        end

        def calculateAllocations(lastName,currentTotal,rowIndex)

          origFile = "#{lastName}.xls"

          #get some preferences for allocations
          puts "Stocks Allocation %: "
          openStocksPercent = gets.chomp.to_i
          puts "Bonds Allocation %:  "
          openBondsAllocation = gets.chomp.to_i
          openCashAllocation = 100 - openStocksPercent - openBondsAllocation
          puts "Your Cash Allocation will be #{openCashAllocation}%."

          stocksValue = currentTotal * openStocksPercent / 100
          bondsValue = currentTotal * openBondsAllocation/ 100
          cashValue = currentTotal * openCashAllocation / 100
          totalValue =  stocksValue + bondsValue + cashValue

          writeInvestmentData(lastName,stocksValue,bondsValue,cashValue,totalValue,origFile,rowIndex)  #now we need to write the first year worth of data to the file

        end

        def calculateYear(lastName)
          #open the portfolio and determine the last row written to (this year!)
          origFile = "#{lastName}.xls"
          ratesFile = "interestrates.xls"
          @currentYearIndex=''
          @stockValue=''
          @bondValue=''
          @cashValue=''
          @stockRate=''
          @bondRate=''
          @cashRate=''
          Spreadsheet.open origFile do |book|        #put this in a block so that the file closes at the end
            @currentYearIndex = book.worksheet(lastName).last_row_index
            sheet1 = book.worksheet lastName
            row = sheet1.row(@currentYearIndex)

            #get the current year information - all cells including the Year
            #write to variables
            year = row[0]
            @stockValue =  row[1].to_i
            @bondValue = row[2].to_i
            @cashValue = row[3].to_i
          end      #close the portfolio


          #open the file for the interest rates
          Spreadsheet.open ratesFile do |book|
            sheet1 = book.worksheet "rates"
            row = sheet1.row(@currentYearIndex)
            #write them to variables
            year = row[0]
            @stockRate = Float(row[1])
            @bondRate = Float(row[2])
            @cashRate = Float(row[3])
          end         #close the interest rate files


          #now, calculate the new values for each
          stocksValueNew = @stockValue * (1 + @stockRate)
          bondsValueNew = @bondValue *  (1 + @bondRate)
          cashValueNew = @cashValue * (1 + @cashRate)
          totalValueNew = stocksValueNew + bondsValueNew + cashValueNew

          puts "#{@stockValue} * #{@stockRate} ==> #{stocksValueNew}"
          puts "#{@bondValue} * #{@bondRate} ==> #{bondsValueNew}"
          puts "#{@cashValue} * #{@cashRate} ==> #{cashValueNew}"
          puts "New Total => #{totalValueNew}"

          #call writeInvestmentData to write the next row (current + 1)
          rowIndex = @currentYearIndex + 1
          writeInvestmentData(lastName,stocksValueNew,bondsValueNew,cashValueNew,totalValueNew,origFile,rowIndex)  #write the new year to the file

        end

        def portfolioExist(lastName)
          portFile = "#{lastName}.xls"
          #check to see if the file exists
          if File.exists?(portFile)
            return TRUE
          else
            return FALSE
          end
        end

        def init_portfolio(lastName)
          yearNum = 1
          origFile = "#{lastName}.xls"

          #This will create an initial year for stocks, bonds, and cash
          puts "How much money do you want to start with?"
          openTotal = gets.chomp.to_i

          #now, let's create our new portfolio workbook
          book = Spreadsheet::Workbook.new
          sheet1 = book.create_worksheet
          sheet1.name = lastName

          #only the header row year, stocks, bonds, total
          sheet1[0,0] = "Year"
          sheet1[0,1] = "Stocks"
          sheet1[0,2] = "Bonds"
          sheet1[0,3] = "Cash"
          sheet1[0,4] = "Total"
          book.write "#{lastName}.xls"

          #now, call getAllocationPreferences to see how we break it up
          calculateAllocations(lastName,openTotal,yearNum)



        end

        def writeInvestmentData(lastName,stocksValue,bondsValue,cashValue,totalValue,origFile,rowIndex)
          #@yearNum = yearNum
          #@lastName = lastName
          yearNum = rowIndex
          tmpFile = "#{lastName}_tmp.xls"

          Spreadsheet.open origFile do |book|        #put this in a block so that the file closes at the end
            sheet1 = book.worksheet lastName

            sheet1[rowIndex,0] = yearNum
            sheet1[rowIndex,1] = stocksValue
            sheet1[rowIndex,2] = bondsValue
            sheet1[rowIndex,3] = cashValue
            sheet1[rowIndex,4] = totalValue

            book.write tmpFile           #create a temp file and writes it out
          end

          File.delete origFile        #need to delete the original file before we can write to it again
          FileUtils.move tmpFile,origFile, :force => true          #move the file

        end

        def publishYear (lastName,rowIndex,header)

          origFile = "#{lastName}.xls"

          Spreadsheet.open origFile do |book|        #put this in a block so that the file closes at the end
            sheet1 = book.worksheet lastName
            row = sheet1.row(rowIndex)

            #check to see if that year exists
            if row[0] != rowIndex
              puts ""
              puts "Message:  This year does not exist in your portfolio!"
              return  #exit out of this and back to the menu
            end

            year = row[0]
            stockValue =  row[1].to_f.round(2)
            bondValue = row[2].to_f.round(2)
            cashValue = row[3].to_f.round(2)
            totalValue = row[4].to_f.round(2)
            if header == 0  #include header
              puts "Year\t\t\tStock Value\t\t\tBond Value\t\t\tCash Value\t\t\tTotal Value"
            end
            #puts "Year:#{year}::Stock Value:#{stockValue}::Bond Value:#{bondValue}::Cash Value:#{cashValue}"
            puts "#{year}\t\t\t\t#{stockValue}\t\t\t#{bondValue}\t\t\t#{cashValue}\t\t\t#{totalValue}"
          end
        end

        def publishSummary(lastName)

          origFile = "#{lastName}.xls"

          stockValues = getAllValuesForColumn(origFile,lastName,1)
          bondValues = getAllValuesForColumn(origFile,lastName,2)
          cashValues = getAllValuesForColumn(origFile,lastName,3)
          totalValues = getAllValuesForColumn(origFile,lastName,4)

          #now that we have the values we need, let's do something with them

          #first, let's take the values and compare one year with another

          #puts stockValues[0]
          i = 0
          num = totalValues.length
          if num == 1
            num =2
          end
          puts "PORTFOLIO SUMMARY - TOTAL VALUATION DIFFERENCES"
          puts "Year\t\tValue\t\t\tYear\t\tValue\t\tDifference($)\t\tDifference(%)"
          begin
            value1 = totalValues[i].to_f
            value2 = totalValues[i + 1].to_f
            diffValue = value2 - value1
            diffPercent = diffValue * 100/value1
            diffValue = diffValue.round(2)
            diffPercent = diffPercent.round(2)
            puts "#{i + 1}\t\t\t#{value1}\t\t#{i+2}\t\t\t#{value2}\t#{diffValue}\t\t\t\t#{diffPercent}"
            i += 1
          end until i == num - 1

          #now show the first and the last full row allocations
          puts ""
          puts "PORTFOLIO SUMMARY - 1ST AND LAST YEAR"
          puts "Year\t\t\tStock Value\t\t\tBond Value\t\t\tCash Value\t\t\tTotal Value"
          publishYear(lastName,1,1) #first row

          #only publish the last year if there IS one
          lastRowIndex = getLastRowIndex(origFile,lastName)
          #puts lastRowIndex
          if lastRowIndex == 1
            #then there has only been one year written to so we skip the "last" row
            #print nothing
          else
            publishYear(lastName,i+1,1) #last row
          end
       end


        def getAllValuesForColumn(fileName,worksheetName,columnIndex)

          @currentYearIndex=''
          #open the portfolio
          @array = []
          Spreadsheet.open fileName do |book|        #put this in a block so that the file closes at the end
            @currentYearIndex = book.worksheet(worksheetName).last_row_index      #get the index of last row written to
            sheet1 = book.worksheet worksheetName
            index = 1   #skip the header row
            begin        #iterate thru the column and get values for each row
              row = sheet1.row(index)
              value = row[columnIndex].to_i         #get the value
              @array.push(value)                    #put the value in the array
              index = index + 1
            end until index == @currentYearIndex + 1
          end                    #closes the file

          return @array


        end

        def getLastRowIndex(fileName,worksheetName)
          @currentYearIndex=''
          Spreadsheet.open fileName do |book|        #put this in a block so that the file closes at the end
            @currentYearIndex = book.worksheet(worksheetName).last_row_index      #get the index of last row written to
          end

          #puts @currentYearIndex
          return @currentYearIndex


        end

        def reallocateCurrentYear (lastName)

          origFile = "#{lastName}.xls"
          @currentTotal = ""
          @currentYearIndex = ""
          #Pick the current year - get the last line in the spreadsheet that has been written
          Spreadsheet.open origFile do |book|        #put this in a block so that the file closes at the end
            @currentYearIndex = book.worksheet(lastName).last_row_index      #get the index of last row written to
            puts "Current Year Data Row Index:  #{@currentYearIndex}"

            #Get the value in the total cell
            sheet1 = book.worksheet lastName
            row = sheet1.row(@currentYearIndex)
            year = row[0]
            @currentTotal = row[4].to_i
            puts "Your current total value is #{@currentTotal}."
          end             #close the spreadsheet before we go to next step

            #Reallocate the cash across each of the
            calculateAllocations(lastName,@currentTotal,@currentYearIndex)

        end

end
require "spreadsheet"

Spreadsheet.client_encoding = 'UTF-8'

fileName = 'Ruby_Report.xls'
book = Spreadsheet.open fileName
@@sheet1 = book.worksheet "report"

def getValue(columnIndex,rowIndex)
  row = @@sheet1.row(rowIndex)
  name = row[columnIndex]
  return name
end




reportName = getValue(1,2)
reportPeriod = getValue(1,5)
origPrincBalTotal = getValue(3,125).to_s
endPrincBalTotal = getValue(4,125).to_s
#loanCountTotal = getLoanCount

origPrincBalTotal = origPrincBalTotal.gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,')
endPrincBalTotal = endPrincBalTotal.gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,')

puts "Report Name:  #{reportName}"
puts "Report Period:  #{reportPeriod}"
puts "Original Principal Balance (Grand Total):  #{origPrincBalTotal}"
puts "Ending Principal Balance (Grand Total):  #{endPrincBalTotal}"






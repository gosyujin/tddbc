require 'rubygems'

class Vending
  def initialize
    @total = 0 
  end

  def enter(money)
    change = []
    money.each do |m|
      if [10, 50, 100, 500, 1000].include?(m)
        @total += m
      else
        change << m
      end
    end
    return change
  end

   def show
     @total
   end

   def cancel
     @total
   ensure
     @total = 0
   end

   def stock
     [120, "Cola", 5]
   end

   def juice_menu
     if @total >= 120 then
       [[120, "Cola"]]
     else 
       []  
     end
   end

   def buy
     @total -= 120
     [[120, "Cola"], @total]
   ensure
     @total = 0
   end
end

if __FILE__ == $0 then 
  e = MyEvernote.new()
end

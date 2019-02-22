require "bigdecimal"

class Vending
  def initialize
    @max_stock = 5
    @current_balance = BigDecimal.new(0)

    @coke_stock = 1
    @pepsi_stock = 1
    @soda_stock = 1
  end

  def run
    input = []
    loop do
      puts "Current Balance: $#{formatted_balance}. What would you like to do? add-money, select-product, refund, leave"
      input = gets.chomp.split(/\s/)
      case input[0]
      when "leave"
        puts "Have a great day!"
        break
      when "select-product"
        select_product input.slice(1..-1)
      when "add-money"
        add_money input.slice(1..-1)
      when "refund"
        puts "Here's your $#{formatted_balance} refund."
        @current_balance = BigDecimal.new(0)
      when "admin-reset"
        reset_options
      end
    end
  end

  def reset_options
      @coke_stock = @max_stock;
      @pepsi_stock = @max_stock;
      @soda_stock = @max_stock;
      puts "Coke: #{@coke_stock}, Pepsi: #{@pepsi_stock}, Soda: #{@soda_stock}"
  end

  def select_product(input)
    selection = input[0]
    case selection
    when "coke"
      coke_stock_check selection
    when "pepsi"
      puts pepsi_stock_check selection
    when "soda"
      puts soda_stock_check selection
    end
  end

  def add_money(input)
    input.each { |number| coin_check number }
  end

  def coin_check number
    goodCoins = [BigDecimal.new("0.01"), BigDecimal.new("0.05"), BigDecimal.new("0.10"), BigDecimal.new("0.25")]

    if goodCoins.include?(BigDecimal.new(number))
      add_to_balance number
    else
      puts "We only take 1, 5, 10 or 25 cents."
    end
  end

  def formatted_balance
    "%.2f" % @current_balance.truncate(2)
  end

  def add_to_balance(number)
    @current_balance = @current_balance + BigDecimal.new(number)
  end

  def coke_stock_check(selection)
    if @coke_stock > 0
      subtract_from_balance selection
    elsif @coke_stock === 0
      puts "We're out of stock on Coke."
    end
  end

  def pepsi_stock_check(selection)
    if @pepsi_stock > 0
      subtract_from_balance selection
    elsif @pepsi_stock === 0
      puts "We're out of stock on Pepsi."
    end
  end

  def soda_stock_check(selection)
    if @soda_stock > 0
      subtract_from_balance selection
    elsif @soda_stock === 0
      puts "We're out of stock on Coke."
    end
  end

  def subtract_from_balance(selection)
    case selection
    when "coke"
      item_price = BigDecimal.new("0.25")
      dispense_output(selection, item_price)
      @coke_stock = @coke_stock - 1
    when "pepsi"
      item_price = BigDecimal.new("0.35")
      dispense_output(selection, item_price)
      @pepsi_stock = @pepsi_stock - 1
    when "soda"
      item_price = BigDecimal.new("0.45")
      dispense_output(selection, item_price)
      @soda_stock = @soda_stock - 1
    end
  end

  def dispense_output(selection, item_price)
    if @current_balance < item_price
      puts "You do not have enough money."
    elsif @current_balance - item_price === 0
      @current_balance = @current_balance - item_price
      puts "Dispensing #{selection.capitalize}. NO CHANGE FOR YOU!"
    elsif
      @current_balance = @current_balance - item_price
      puts "Dispensing #{selection.capitalize}. Here's your $#{formatted_balance} change."
    end
  end

end

go = Vending.new
go.run

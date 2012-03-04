class Foo
	attr_accessor :title, :price

	def initialize(title, price)
		@title = title
		@price = price
	end

end

class Bar
	attr_accessor :name

	def initialize(name)
		@name = name
	end

end

class Price
	attr_accessor :amount, :currency

	def initialize(amount, currency)
		@amount 	= amount
		@currency = currency
	end

end

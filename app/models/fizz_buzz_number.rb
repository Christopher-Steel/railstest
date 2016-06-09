class FizzBuzzNumber
  WORD_MATCHERS = [
    ['Fizz', 3],
    ['Buzz', 5]                 
  ] 

  def initialize(number)
    @number = number
    @string = ''
  end

  def to_i
    @number
  end
  alias_method :to_int, :to_i

  def to_s
    return @string unless @string.empty?
    WORD_MATCHERS.each do |word, multiplier|
      @string += word if @number.multiple_of?(multiplier)
    end
    @string = @number.to_s if @string.empty? 
    @string
  end

  def self.range(numbers)
    numbers.map { |n| self.new(n) }
  end
end

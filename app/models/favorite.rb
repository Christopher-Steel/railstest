class Favorite < ActiveRecord::Base
  validates(
    :number,
    numericality: { only_integer: true },
    presence: true,
    uniqueness: true
  )

  def to_i
    number
  end
  # defining to_int expresses that this class can be
  # considered as equivalent to an int over simply being
  # convertable to an int
  alias_method :to_int, :to_i
end

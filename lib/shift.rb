class Shift

  attr_reader :character_set

  def initialize
    @character_set = character_set
  end

  def create_character_set
    @character_set = ("a".."z").to_a << " "
  end

end

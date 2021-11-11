require_relative './spec_helper'
require './lib/shift'

RSpec.describe Shift do

  before(:each) do
    @shift = Shift.new
  end

  it 'exists' do
    expect(@shift).to be_instance_of(Shift)
  end

  it 'has attributes' do
    expect(@shift.create_character_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
  end
end

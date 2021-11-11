require_relative './spec_helper'
require './lib/shift'

RSpec.describe Shift do

  before(:each) do
    @shift = Shift.new
  end

  it 'exists' do
    expect(@shift).to be_instance_of(Shift)
  end
end

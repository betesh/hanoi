require File.expand_path("../../hanoi", __FILE__)

def expect_invalid_input_error(input, message)
  begin
    hanoi = Hanoi.new(input)
  rescue InvalidInputError => e
    e.message.should eq(message)
  end
end

describe "invalid inputs" do
  it "should raise an error if input is not an Integer" do
    expect_invalid_input_error("abc", "ring_count must be a positive integer, not 'abc'!")
  end
  it "should raise an error if input is a negative Integer" do
    expect_invalid_input_error(-3, "ring_count must be a positive integer, not '-3'!")
  end
  it "should raise an error if input is zero" do
    expect_invalid_input_error(0, "ring_count must be a positive integer, not '0'!")
  end
end


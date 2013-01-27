class InvalidInputError < StandardError
end
class Hanoi
  def initialize(ring_count)
    @ring_count = ring_count
    validate_ring_count
    start_over!
  end

  def play!
  end

  private
    def validate_ring_count
      raise InvalidInputError.new("ring_count must be a positive integer, not '#{@ring_count}'!") unless @ring_count.is_a?(Integer) && @ring_count > 0
    end

    def start_over!
    end

    def move!
    end

    def game_over?
    end
end

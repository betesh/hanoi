class InvalidInputError < StandardError
end
class Hanoi
  def initialize(ring_count)
    @ring_count = ring_count
    @attempts = 0
    validate_ring_count
    start_over!
  end

  def play!
    until game_over?
      @attempts = @attempts + 1
      puts "Beginning attempt ##{@attempts}"
      while move! do; end
      unless game_over?
        puts "On attempt ##{@attempts}, after #{@moves.size+1} moves, there are no legal moves.  This did not result in a solution."
        puts "Attempt ended with left: #{@towers[0].inspect}; middle: #{@towers[1].inspect}; right: #{@towers[2].inspect}"
        puts "Move summary: #{@moves.inspect}"
        puts
        start_over!
      end
    end
    puts "Game over.  On attempt ##{@attempts}, we win after #{@moves.size+1} moves."
    puts "Move summary: #{@moves.inspect}"
  end

  private
    def validate_ring_count
      raise InvalidInputError.new("ring_count must be a positive integer, not '#{@ring_count}'!") unless @ring_count.is_a?(Integer) && @ring_count > 0
    end

    def start_over!
      @towers = [Array.new, Array.new, Array.new]
      (1..@ring_count).each { |i| @towers[0] << i }
      @towers[0].reverse!
      @previous_destination = nil
      @moves = []
    end

    def select_source
      # Source cannot be previous destination or an empty column.
      @allowed_sources.delete(@previous_destination) if @previous_destination
      @allowed_sources.delete_if { |i| @towers[i].empty? }
      puts "\tAvailable sources: #{@allowed_sources.inspect}"
      @source = @allowed_sources.empty? ? nil : @allowed_sources[Random.rand(@allowed_sources.size)]
    end

    def source_has_larger_ring?(i)
      !@towers[i].empty? && @towers[i].last < @towers[@source].last
    end

    def select_destination
      # Destination cannot be source and cannot be a tower whose top ring is < the top ring of the source
      allowed_destinations = [0,1,2]
      allowed_destinations.delete(@source)
      allowed_destinations.delete_if { |i| source_has_larger_ring?(i) }
      puts "\tAvailable destinations for source #{@source}: #{allowed_destinations.inspect}"
      @destination = allowed_destinations.empty? ? nil : allowed_destinations[Random.rand(allowed_destinations.size)]
    end

    def move!
      puts "Move ##{@moves.size+1}"
      @allowed_sources = [0,1,2]
      return false unless select_source
      while !select_destination do
        @allowed_sources.delete(@source)
        return false unless select_source
      end
      ring = @towers[@source].pop
      @towers[@destination] << ring
      @moves << "Ring ##{ring} from #{@source} to #{@destination}"
      @previous_destination = @destination
    end

    def game_over?
      @towers[0].empty? && @towers[1].empty?
    end
end

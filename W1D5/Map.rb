class Map
  attr_reader :my_map

  def initialize
    @my_map = []
  end

  def set(key, value)
    i = 0

    while i < my_map.length
      if my_map[i].first == key
        my_map.delete_at(i)
      end
      i += 1
    end
    my_map << [key , value]
  end
end

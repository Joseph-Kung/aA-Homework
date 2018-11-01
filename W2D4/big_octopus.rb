FISH = ['fish',
        'fiiish',
        'fiiiiish',
        'fiiiish',
        'fffish',
        'ffiiiiisshh',
        'fsh',
        'fiiiissshhhhhh']


#O(n^2)
def sluggish_octopus
  FISH.each_with_index do |fish, i|
    max = true
    FISH.each_with_index do |fish2, i2|
      next if i == i2
      max = false if fish2.length > fish.length
    end

    return fish if max == true
  end
end

#O(n)
def clever_octopus
  longest = ''

  FISH.each do |fish|
    longest = fish if fish.length > longest.length
  end
  longest
end

#O(n log n)
def dominant_octopus
  prc = Proc.new { |x,y| y.length <=> x.length}
  FISH.merge_sort(&prc).first
end

class Array
  def merge_sort(&prc)
    prc ||= Proc.new {|x,y| x <=> y}
    return self if self.length <= 1

    half = self.length / 2
    left = self.take(half).merge_sort(&prc)
    right = self.drop(half).merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  def self.merge(left, right, &prc)
    result = []

    until left.empty? || right.empty?
      if prc.call(left.first, right.first) == 1
        result << right.shift
      else
        result << left.shift
      end
    end
    result + left + right
  end
end

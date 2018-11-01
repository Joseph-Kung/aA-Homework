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
  longest = ''

  FISH.each do |fish|
    longest = fish if fish.length > longest.length
  end
  longest
end

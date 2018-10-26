class Stack
  attr_reader :stack

  def initialize
    @stack = []
  end

  def push(el)
    stack << el
  end

  def pop
    answer = []
    stack.each_with_index do |el, idx|
      answer << el unless idx == stack.length - 1
    end
    answer
  end

  def peek
    stack.first
  end
end

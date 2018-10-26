class Queue
  attr_reader :que

  def initialize
    @que = []
  end

  def enqueue(el)
    que.unshift(el)
  end

  def dequeue
    que.pop
  end

  def peek
    que.last
  end
end

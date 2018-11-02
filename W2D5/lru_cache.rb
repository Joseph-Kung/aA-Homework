class LRUCache
   def initialize(size)
     @size = size
     @cache = []
   end

   def count
     @cache.count
   end

   def add(el)
     if @cache.include?(el)
       @cache.delete(el)
       @cache << el
     elsif self.count >= @size
       @cache.shift
       @cache << el
     else
       @cache << el
     end
   end

   def show
     p @cache
     return nil
   end

   private
   # helper methods go here!
   attr_reader :cache, :size
 end

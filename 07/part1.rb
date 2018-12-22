# frozen_string_literal: false

require 'awesome_print'
require 'tsort'

# commentary
class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end




h = Hash.new { |h,k| h[k]  = []}

h['C'] << 'A' # => ["A"]
h['C'] << 'F' # => ["A", "F"]
h['A'] << 'B'
h['A'] << 'D'
h['B'] << 'E'
h['D'] << 'E'
h['F'] << 'E'
h['E']

h.each { |k,v|
   v.sort!
}
h = h.sort.to_h

#p h.tsort

c =  {"c" => ["f", "a"] , "b" => ["e"], "a" => ["d", "b"], "d" => ["e"], "e"  => [], "f" => ["e"]}
c.each{ |k, v| v.sort! }
p c
c = c.sort.to_h
p c
p c.tsort

# , 'B' => ['D'], 'C' => ['A', 'F'], 'D' => ['D'], 'E' => [], 'F' => ['E'] }

# >> {"c"=>["a", "f"], "b"=>["e"], "a"=>["b", "d"], "d"=>["e"], "e"=>[], "f"=>["e"]}
# >> {"a"=>["b", "d"], "b"=>["e"], "c"=>["a", "f"], "d"=>["e"], "e"=>[], "f"=>["e"]}
# >> ["e", "b", "d", "a", "f", "c"]

# class Parser
#   def parse_string(str)
#     arr = str.split(/ /)
#     arr.each do |el|
#       if el.match(/[-]/)
#         el = find_dash(el)
#       end
#     end
#   end

#   def find_dash(str)
#     rez = ''
#     str.each_char do |n|
#       if n != "-"
#         rez << n
#       else
#         break
#       end
#     end
#     rez2 = str.slice!(rez)
#     [rez2, str]
#   end
# end
# d = Parser.new
# a = "To be or not to be-that is the question"

# d.parse_string(a)

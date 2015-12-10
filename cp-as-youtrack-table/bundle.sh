#!/usr/bin/ruby
require 'csv'

def pbcopy(input)
 IO.popen('pbcopy', 'w') { |f| f << input.to_s }
end

lines = $stdin.readlines
output = ''

col_names = CSV.parse(lines.shift)
output << col_names.join('||').concat("||\n").prepend('||')

lines.each do |row|
  elements = CSV.parse(row).flatten
  elements.map!{ |e| e.empty? ? " " : e }
  output << elements.join('|').concat("|\n").prepend('|')
end

puts "Copied as YouTrack table"
pbcopy(output)

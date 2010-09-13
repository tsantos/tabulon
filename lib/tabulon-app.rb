
require 'tabulon'
require 'optparse'

@delim = "\t"
@headers = false
@searchable = false

opts = OptionParser.new do |opts|
   opts.banner = <<EOF

Tabulon is both a requireable gem and a command line utility for displaying and navigating csv data within a window.

### Simple Command Line Examples

    > grep a-term /path/to/file.csv | tabulon -c -s

    > tabulon --headers /path/to/file.csv

### Simple Gem Example

    require 'tabulon'

    tabulon = Tabulon.new('/path/to/file.csv') do |t|
       t.headers
       t.searchable
       t.delim    = ','
       t.size     = [600, 400]
       t.location = [100, 100]
    end

    tabulon.show

### Options

EOF
   opts.on('-c', '--commas', "Comma delimited") { @delim = ',' }
   opts.on('-d', '--delimiter DELIM', "Specify delimiter") { |delim| @delim = delim }
   opts.on('--headers', "Read column headers from first non-blank line.") { @headers = true }
   opts.on('-s', '--searchable', "Make the contents of the data searchable (more overhead).") {@searchable = true }
   opts.on('-h', '--help', 'Show this message') { puts opts; exit }
end
opts.parse! ARGV

if ARGV.empty?
   input = STDIN
else
   input = open(ARGV[0])
end

tabulon = Tabulon.new(input) do |t|
   t.headers    if @headers
   t.searchable if @searchable
   t.delim    = @delim
   t.size     = [600, 400]
   t.location = [100, 100]
end

input.close

tabulon.show

# vim: filetype=ruby tabstop=3 expandtab 

Tabulon is both a requireable gem and a command line utility for displaying and
navigating csv data within a window. It's going to include indexing for narrowing
the number of visible rows.


It requires JRuby

v 0.1

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

### Simple Command Line Examples

    > grep a-term /path/to/file.csv | tabulon -c -s

    > tabulon --headers /path/to/file.csv 



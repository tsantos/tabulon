
require 'java'

class Tabulon
   module AWT
     include_package 'java.awt'
     # include_package 'java.awt.event'
   end
   
   module Swing
     include_package 'javax.swing'
     include_package 'javax.swing.table'
     # include_package 'javax.swing.event'
   end

   attr_accessor :size, :location, :delim, :headers

   def initialize input
      @read_headers  = false
      @searchable    = false
      @delim         = "\t"
      @frame         = Swing::JFrame.new('Tabulon')
      @size          = [600, 400]
      @location      = [100, 100]
      @headers       = []

      yield(self) if block_given?

      @frame.size     = AWT::Dimension.new(@size[0], @size[1])
      @frame.location = AWT::Point.new(@location[0], @location[1])

      @frame.default_close_operation = Swing::JFrame::EXIT_ON_CLOSE

      model = Swing::DefaultTableModel.new()

      # Nab the headers
      if @read_headers
         headers = next_line(input)
         if headers
            headers.each { |h| model.add_column(h) }
         end
      end
      
      # Load the input
      rows = []
      max_width = 0
      while row = next_line(input)
         max_width = [max_width, row.length].max
         rows << row
      end

      model.column_count = max_width if @headers.empty?

      rows.each { |row| model.add_row(row.to_java) }

      @table = Swing::JTable.new(model)

      # Fix the column widths
      @table.column_model.columns.each { |col| col.preferred_width = 100 }
      @table.auto_resize_mode = Swing::JTable::AUTO_RESIZE_OFF

      scroller = Swing::JScrollPane.new(@table)
      @frame.content_pane.add(scroller, AWT::BorderLayout::CENTER)
   end

   def headers
      @read_headers = true
   end

   def searchable
      @searchable = true
   end

   def show
      @frame.visible = true
   end

   def hide
      @frame.visible = false
   end

   def next_line input
      while line = input.gets
         line.chomp!
         unless line.empty?
            return line.split(@delim)
         end
      end
      nil
   end
end

# vim: filetype=ruby tabstop=3 expandtab 

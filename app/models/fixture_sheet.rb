class FixtureSheet < ActiveRecord::Base
  has_one :element, :as => :resource, :dependent => :destroy
  has_many :cells, :dependent => :destroy
  attr_accessor :is_blank
  #this method creates a new table cell based on the information in the 
  #hash
  
  def get_cells
    self.cells
  end
  
  def add_cell(cell_data)
      c = Cell.new(cell_data)
      self.cells << c
      self.save
   end
    
  #this method returns a cell at the specified row/column index
  def get_cell(row,col)
    cells.each do |c|
        if (c.row == row && c.col == col)
            return c
        end
      end
      return nil
   end
   
   #this method expects a block.  It accepts a row and column as input and will
   #apply the passed in block to the cell denoted by (row,col)
   def process_cell(row,col)
     cells.each do |c|
       if (c.row == row && c.col == col)
         yield c
         break
       end
     end
     
   end
    
  #this method adds a set of blank rows.  It uses the number of columns to
  #determine how many cells to create.  Also, it increments the row count and
  #sets each cell's row number to the incremented count.
  def add_row
    0.upto(columns-1) do |i|
        self.cells << Cell.new({:data => "blank", :row => self.rows, :col => i})
      end
    #rows should index from zero, so incrment this after adding the row.
    self.rows += 1
    self.save
  end
  
  #this method returns an array of cells that all share that index.  Additionally, the
  #cells need to be sorted on their column index.
  def get_row(index)
    #puts "Number of cells in table: #{cells.length}"
    thisrow = Array.new
    #iterate over the cells list and add the cells with row = index to a list
    self.cells.each do |c|
      #puts "Cell is in row #{c.row}"
        if(c.row == index)
            thisrow << c
        end
    end
      
    #sort the list on the cells column number
    thisrow.sort_by {|c| c.col}
    
  end
  
  def insert_row(newcells, index)
  #first, loop over the existing cells, and for each cell whose row value is equal to or
  #greater than index, increment it by 1.
      #puts "Rows in Table before insert: #{self.rows}"
      self.cells.each do |c|
        #puts "Accessing Cell(#{c.row},#{c.col}) row: #{c.row}"
        c.row += 1 if c.row >= index
      end
      
      #now, insert the cells
      newcells.each {|ce| cells << ce}
      self.rows += 1
       #puts "Rows in Table After insert: #{self.rows}"
     
      self.save
    end 
    
  
  def delete_row(index)
      #first, clear out the row to be deleted
      self.cells.each_with_index do |c,i|
        self.cells[i].delete if c.row == index
      end
        
      #now, update the remaining cells to ensure they have the correct row numbers
      self.cells.each do |c|
        c.row -= 1 if c.row > index
      end
      
      #now, up date the row count in the table
      self.rows -= 1
      
  end
  
  
  
  
end

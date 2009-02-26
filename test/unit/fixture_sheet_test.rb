require File.dirname(__FILE__) + "/../test_helper"

class FixtureSheetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :fixture_sheets, :cells
  def test_truth
    assert true
  end
  
   def test_add_cell
      t = FixtureSheet.find(fixture_sheets(:one).id)
      puts "SHEET ID: #{t.id}"
      t.add_cell({:row=>1,:col=>2,:data=>"A New Cell"})
      c = t.process_cell(1,2){|cell| return cell}
      assert_equal "A New Cell", c.data
    end
    
  def test_add_row_blank
    #I think I want this method to work by accepting an array of cells and
    #adding them as one complete row.  Maybe I will default to add a set of empty
    #cells each with a row number greater than what is in the table's row field.
    #The number of cells will coorespond to the number of columns
    t = FixtureSheet.find(fixture_sheets(:one).id)
    t.add_row
    assert_equal t.rows,3
    
    t.get_cells().each{|c| puts "ROW: #{c.row} COL: #{c.col} DATA: #{c.data}"}
    
    c = t.get_cell(2,1)
    assert_equal "blank",c.data
      
  end
    
    
  def test_get_row
      #this method should return a list of cells belonging to a particular row
      t = FixtureSheet.find(fixture_sheets(:one).id)
      t.add_row
      t.add_row
      t.add_row
      
      #add
      cells = t.get_row(3)
      
      assert_equal 3, cells.length
      assert_equal 0, cells[0].col
      assert_equal 1, cells[1].col
      assert_equal 2, cells[2].col
  end
  
  
  def test_insert_row
    #this method will insert a set of cells at the specified index.
    #this method will create a set of blank cells
    t = FixtureSheet.find(fixture_sheets(:one).id)
    #set up the sheet with 3 rows
    t.add_row
    t.add_row
    t.add_row
    
    #set up the cell_list
    cell_list = Array.new
    cell_list[0] = Cell.new({:row => 3, :col=>0, :data=>"Inserted Cell 1"})
    cell_list[1] = Cell.new({:row => 3, :col=>1, :data=>"Inserted Cell 2"})
    cell_list[2] = Cell.new({:row => 3, :col=>1, :data=>"Inserted Cell 3"})
    
    t.insert_row(cell_list,3)
    
    #now, check that the number of rows in the table has gone up by one
    assert_equal 6,t.rows
    
    #get the row, and make sure the cells are correct
    cells = t.get_row(3)
    assert_equal "Inserted Cell 1",cells[0].data
    assert_equal "Inserted Cell 2",cells[1].data
    assert_equal "Inserted Cell 3",cells[2].data
    
  end
  
  def test_delete_row
      #this tests a method that will remove a row from the table. 
      #It will need to find the row to delete, remove each cell with that row number
      #from the object model/database.  Then, it will need to adjust the row counts
      #of the adjacent rows - all cells with a row number greater than this row will have
      # 1 subtracted
      t = FixtureSheet.find(fixture_sheets(:one).id)
      #add some rows
      t.add_row
      t.add_row
      t.add_row
      
      #remove row 4th row (index of 3)
      t.delete_row(3)
      
      #check the row count
      assert_equal 4, t.rows
      
      #make sure there is still a 4th row
      cells = t.get_row(3)
      assert_not_nil cells
      
      #make sure we can't get the 5th row
      assert_equal 0,t.get_row(4).size
  end
  
  def test_process_cell_get
    #this method tests whether or not we can find a particular cell by passing in a
    #row and column.
    f = FixtureSheet.find(fixture_sheets(:one).id)
    cell = f.process_cell(0,0){|c| return c}
    assert_equal "Cell 1",cell.data
    
    cell = f.process_cell(1,1){|c| return c}
    assert_equal "Cell 5",cell.data
  
  end

  def test_process_cell_update_data
    f = FixtureSheet.find(fixture_sheets(:one).id)
    f.process_cell(1,1){|c|c.data = "Updated Cell Data"}
    
    cell = f.get_cell(1,1)
    assert_equal "Updated Cell Data",cell.data
  end
  
  
#end of test class  
end

class Cell < ActiveRecord::Base
  #Cells belong to test tables, set up that relationship here
  belongs_to :test_table
end

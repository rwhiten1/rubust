class TestTable < ActiveRecord::Base
  #link each TestTable to an element
  has_one :element, :as => :resource
  
  #A table has many individual cells
  has_many :cells
  
end

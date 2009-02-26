class Heading < ActiveRecord::Base
  #link each Heading to an element
  has_one :element, :as => :resource, :dependent => :destroy
  
end

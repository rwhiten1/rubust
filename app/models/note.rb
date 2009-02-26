class Note < ActiveRecord::Base
  #link each Note to an Element
  has_one :element, :as => :resource, :dependent => :destroy
end

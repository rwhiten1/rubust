class Element < ActiveRecord::Base
  #set up a polymorphic relationship to Heading, Note, and TestTable
  belongs_to :resource, :polymorphic => true
  belongs_to :page
  acts_as_list :scope => :page
  
  #~ def self.get_with_resource_type_and_resource_id(id,c)
    #~ puts("Resource ID: #{id}\n Resource Type: #{c}")
    #~ e = Element.find(:first, 
                      #~ :conditions => ["resource_type=:rtype and resource_id=:rid", {:rtype => c, :rid => id}])
                      
                      #~ #:conditions => ["resource_type = :rtype and resource_id = :rid", 
                      #~ #{:rtype => type.class, :rid => type.id}])
    #~ e
  #~ end
  
  
end

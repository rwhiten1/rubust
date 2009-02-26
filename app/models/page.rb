class Page < ActiveRecord::Base
  #Pages together will make a tree.  Hopefully there will be a way to have a "forest"
  acts_as_tree :order => "name"
  #a page can have many variables
  has_many :variables, :dependent => :destroy
  #a page has many elements 
  has_many :elements, :order => :position, :dependent => :destroy
  
  
  def add_element(element)
    if(element.new_record?)
      element.save
    end
    
    e = Element.new
    e.resource = element
    elements << e
    #e.add_to_list_bottom
    self.save
  end
  
  def element_count
    elements.size
  end
  
  def get_element_list
    self.reload(:lock => true)
    elements
  end
  
  def variable_count
    variables.size 
  end
  
  
  def delete_element_by_id(element)
      
      process_element_with_resource(element) do |e|
          self.elements.delete(e)
          e.remove_from_list
          e.destroy
      end
      element.destroy
      self.save!
      
   #end delete_element_by_id   
 end
 
 def insert_element(thing,index)
   #need to first add the element, if it doesn't already exist in the database
   #then, call insert_at
   #e = process_element_with_resource(thing){|e| return e}
    if(thing.new_record?)
      add_element(thing)
    end
  
    process_element_with_resource(thing) {|e|  e.insert_at(index)}
    self.save
  end
  
  def process_element_with_resource(r)
    elements.each do |e|
      if(e.resource.class == r.class && e.resource_id == r.id)
        yield e
        break
      end
    end
    
  end
  
 
    
  def add_page(p)
    self.children.create({:name => p.name})
  #end add_page
  end

  def add_variable(var)
    self.variables << var
    self.save!
  end
  
  def get_variable_by_name(name)
    #val = ""
    page = self
   
    while(page.parent != nil)
      page.variables.each do |v| 
        return v.value if v.name == name
      end
      page = Page.find(page.parent_id)
    end
    
    #if we get here, then we are on the root and its variable list hasn't been traversed
    page.variables.each {|v| return v.value if v.name == name}
  end #end get_variable_by_name
  
  

####
#End of the class
####
end

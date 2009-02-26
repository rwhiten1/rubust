require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :pages, :variables, :fixture_sheets, :cells, :headings, :notes
  def test_truth
    assert true
  end
  
  def test_find_by_parent_id
    #tries to find a page using the parent_id field
    page = Page.find_by_parent_id(1)
    assert_equal "ChildPage3",page.name
  end
  
  def test_find_by_name
    #tries to find a page using the name field
    page = Page.find_by_name("FrontPage")
    assert_not_nil page
    assert_equal 1, page.children.size
  end
  
  def test_add_element
   #this tests that elements can be added to the page
   #the method accepts a table, heading, or note and adds it to a new
   #element in its element list
   page = Page.find(pages(:one).id)
   t1 = FixtureSheet.find(fixture_sheets(:one).id)
   h1 = Heading.find(headings(:one).id)
   
   page.add_element(t1)
   assert_equal 1, page.element_count
   
   page.add_element(h1)
   assert_equal 2,page.element_count
 end
 
 def test_remove_element_by_id
   #this test verifies that an emlement can be removed from the list
   #by id. 
   page = Page.find(pages(:one).id)
   t1 = FixtureSheet.find(fixture_sheets(:one).id)
   h1 = Heading.find(headings(:one).id)
   n1 = Note.find(notes(:one).id)
   
   #add the elements
   page.add_element(h1)
   page.add_element(n1)
   page.add_element(t1)
   
   assert_equal 3,page.element_count
   
   page.delete_element_by_id(n1)
   
   #assert_equal 2,page.element_count
   
   e_s = page.get_element_list
   #assert_equal 2, e_s.size
   assert_equal h1.class, e_s[0].resource.class
   assert_equal t1.class, e_s[1].resource.class
 end
 
 def test_find_element_with_resource
    #This method verifies that the page can find an element in its list
    #using a specified resource
    page = Page.find(pages(:one).id)
    h1 = Heading.find(headings(:one).id)
    page.add_element(h1)
    
    elem = page.process_element_with_resource(h1){|e| return e}
    
    assert_equal 1,elem.position
    assert_equal h1.class, elem.resource.class
 end
 
 
 def test_insert_element
  #this test verifies that a new element can be inserted into the middle of the list somewhere
  page = Page.new({:name=>"Test Page"})
  page.save
  t1 = FixtureSheet.new({:name => "TestTable1", :fixture=>"FixtureClass1", :rows=>2,:columns=>4})
  h1 = Heading.new({:value=>"Heading 1",:size=>1})
  n1 = Note.new({:data=>"This a note!"})
  
  page.add_element(h1)
  page.add_element(n1)
  page.add_element(t1)
  
  #now, create a new fixturesheet/table and insert it
  t2 = FixtureSheet.new({:name => "TestTable3", :fixture=>"FixtureClass", :rows=>2,:columns=>4})
  page.insert_element(t2,2)
  
  els = page.get_element_list
  els.each {|e| puts "type: #{e.resource.class}, position: #{e.position}"}
  
  assert_equal 4,page.element_count
  assert_equal t2.class,els[1].resource.class
  assert_equal 1, els[0].position
  assert_equal 2, els[1].position
  assert_equal 3, els[2].position
  assert_equal 4, els[3].position
  
  
  hres = els[0].resource
  nres = els[2].resource
  tres = els[1].resource
  
  assert_equal h1.value, hres.value
  assert_equal t2.name, tres.name
  assert_equal n1.data, nres.data
  
  
end

def test_move_element
    page = Page.find(pages(:one).id)
    h1 = Heading.find(headings(:one).id)
    n1 = Note.find(notes(:one).id)
    t1 = FixtureSheet.find(fixture_sheets(:one).id)
    h2 = Heading.find(headings(:two).id)
    
    page.add_element(h1)
    page.add_element(n1)
    page.add_element(t1)
    page.add_element(h2)
    
    #h2 should be at position four now.
    e = page.process_element_with_resource(h2){|r| return r}
    assert_equal 4,e.position
    
    #now, move h2 by calling insert_at
    page.insert_element(h2,2)
    
    #get the elements
    e1 = page.process_element_with_resource(h1){|r| return r}
    e2 = page.process_element_with_resource(h2){|r| return r}
    e3 = page.process_element_with_resource(n1){|r| return r}
    e4 = page.process_element_with_resource(t1){|r| return r}
    
    assert_equal 1,e1.position
    assert_equal 2,e2.position
    assert_equal 3,e3.position
    assert_equal 4,e4.position
end

 
 
def test_add_page
  root = Page.find(pages(:one).id)
  child1 = Page.find(pages(:four).id)
  child2 = Page.find(pages(:five).id)
  
  #add the children
  root.add_page(child1)
  root.add_page(child2)
  
  assert_equal 3,root.children.size
end

def test_add_variable
  #add variables to a page, then verify they exist
  page = Page.find(pages(:one).id)
  v1 = Variable.find(variables(:three).id)
  page.add_variable(v1)
  assert_equal 3, page.variable_count
  
end

def test_get_variable_value
  page = Page.find(pages(:one).id)
  assert_equal "Value 2", page.get_variable_by_name("VAR2")
    
  end
  
  def test_get_var_val_from_root
  #this test is meant to test test page variable inheritance.  A child page inherits
  #variables from its parent.  All the variables in the fixtures belong to the root page.
    page = Page.find(pages(:three).id)
    assert_equal "MyString", page.get_variable_by_name("VAR1")
  end
  
  def test_get_var_val_from_parent
    page = Page.find(pages(:three).id)
    pare = Page.find(pages(:two).id)
    #add a variable to pare
    pare.add_variable(Variable.find(variables(:three).id))
    assert_equal "Add This", page.get_variable_by_name("VAR3")
    
  end
  
  



 
  
end

require 'test_helper'

class FixturePagesControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_show_page_with_id
    #show the test page based on the ID
    get(:showPage,{'id'=> "953125641"})
    p = assigns(:page)
    assert_response :success
    assert_equal "FrontPage",p.name 
  end
  
  def test_show_page_no_id
    get(:showPage)
    p = assigns(:page)
    assert_response :success
    assert_equal "FrontPage",p.name
  end
  
  def test_add_heading_to_page
    #this test verifies that the controller can add a heading to a page
    xhr(:post,:addHeading, {'id' => "953125641", :heading=>{:value=>"A New Heading",:size=>"3"}})
    assert_response :success
    #make sure that the Heading has been added to
    page = Page.find(pages(:one).id)
    assert_equal 1,page.get_element_list.size
    
  end
  
  def test_add_note_to_page
    xhr(:post,:addNote, {'id' => "953125641", :note=>{:data => "I have writen a new note!"}})
    assert_response :success
    
    page = Page.find(pages(:one).id)
    assert_equal 1,page.get_element_list.size
  end
  
  def test_add_table
    xhr(:post, :addTable, {'id' =>"953125641", :fixture_sheet=>{:columns=>"3",:rows=>"4",:fixture=>"ColumFixture", :name=>"TestTable3"}})
    assert_response :success
    
    page = Page.find(pages(:one).id)
    assert_equal 1,page.get_element_list.size
    
    #verify the table as well
    t = FixtureSheet.find_by_name("TestTable3")
    #verify the number of columns in each row
     assert_equal true,t.is_blank?
    assert_equal 3,t.get_row(0).size
    assert_equal 3,t.get_row(1).size
    assert_equal 3,t.get_row(2).size
    assert_equal 3,t.get_row(3).size
   
  end
  
  def test_update_table
    table = FixtureSheet.find(fixture_sheets(:one))
    element = Element.find(elements(:one))
    element.resource = table
    page = Page.find(pages(:one))
    page.add_element(table)
    cells = {'0'=>{'0'=>{:data=>"Data 1"},'1'=>{:data=>"Data 2"},'2'=>{:data=>"Data 3"}},
            '1' => {'0'=>{:data=>"Data 4"},'1'=>{:data=>"Data 5"},'2'=>{:data=>"Data 6"}}}
    
    xhr(:post, :updateTable, {'id'=>"1", :cell=>cells})
    assert_response :success
    #elem = assigns(:element)
    #assert_equal 953125641,elem.page_id
    
    table = FixtureSheet.find(fixture_sheets(:one))
    row = table.get_row(0)
    assert_equal 3,row.size
    
    row = table.get_row(1)
    assert_equal 2,row.size
    
    assert_equal "Data 1",table.get_cell(0,0).data
    assert_equal "Data 4",table.get_cell(1,0).data
    
  end
  
  def test_update_heading
    
    #this test verfies that a heading can be updated
    h = Heading.find(headings(:one).id)
    p = Page.find(pages(:one).id)
    p.add_element(h)
    xhr(:post, :updateHeading, {'id' => h.id, :value=>"Updated Heading"})
    assert_response :success
    h = Heading.find(headings(:one).id)
    assert_equal "Updated Heading",h.value
  end
  
  def test_update_note
    #this verifys a note can be updated
    n = Note.find(notes(:one))
    p = Page.find(pages(:one))
    p.add_element(n)
    
    xhr(:post, :updateNote, {'id'=>n.id, :value=>"This note has new text"})
    n = Note.find(notes(:one))
    assert_equal "This note has new text",n.data
  end
  
  
end

require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  #~ def test_find_by_resource_type_and_id
    #~ #this tests that the find_by_resource_type_and_resource_id method
    #~ #accepts one of the element types as a parameter and returns the
    #~ #Element associated with it.
    #~ n = Note.find(notes(:two))
    #~ e_expected = Element.new({:position => 3}) #Element.find(elements(:two))
    #~ e_expected.resource = n
    #~ e_expected.save
    
    #~ e_actual = Element.find_with_resource_type_and_resource_id(n.id, n.class)
    
    #~ assert_equal e_expected.position, e_actual.position
    #~ assert_equal e_expected.resource.data, n.data
    
  #~ end
  
end

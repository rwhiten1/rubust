class FixturePagesController < ApplicationController
  layout "main_pages"
  #in_place_edit_for :note, :data
  #in_place_edit_for :heading, :value
  def showPage
    if(params[:id])
      @page = Page.find(params[:id]) #this is temporary
    else
      @page = Page.find_by_name("FrontPage") #FrontPage will the initial entry point
      #Create FrontPage if it doesn't exist.
      @page = Page.new({:name => "FrontPage"}) if @page == nil 
    end
  end
  
  def addTable
    t = FixtureSheet.new(params[:fixture_sheet])
    t.toggle(:is_blank) if !t.is_blank?
    0.upto(t.rows-1) do |i|
      0.upto(t.columns-1) do |j|
        t.add_cell({:row => i, :col => j, :data => "blank"})
      end
    end
    addElement(t){render :partial => 'elements_list', :locals=>{:page=>@page}}
  end
  
  def updateTable
    
    table = FixtureSheet.find(params[:id])
    cells = params[:cell]
    #this is a nested hash, how do you loop over a nested hash?
    row = -1
    cells.each_pair do |key,val|
      row = key.to_i if key != "data"
      val.each_pair do |k,v|
       #puts "Cell[#{row}][#{k.to_i}] = #{v[:data]}"
       #puts "\tUPDATING CELL: #{acell.id} ROW: #{acell.row} COL: #{acell.col}"
       table.process_cell(row,k.to_i)do |c|
         c.data = v[:data]
         c.save
       end
      end
    end
    table.toggle(:is_blank)
    table.save
    #look up the page by finding this table's element
    elem = Element.find(:first, :conditions => ["resource_type = :rtype AND resource_id = :rid", {:rtype => "FixtureSheet", :rid => table.id}])
    render :partial=>"fixture_update", :locals=>{ :element=>elem }
    
  end

  def addHeading
    #now, render the AJAX response.  The list of elements should be a UL on the
    #page with an ID of elements_list
     h = Heading.new(params[:heading])
     addElement(h){render :partial => 'elements_list', :locals=>{:page => @page}}
  end
  
  #update a heading, via an inline form
  def updateHeading
    h = Heading.find(params[:id])
    h.value = params[:value]
    h.save
    #elem = Element.find(:first, :conditions => ["resource_type = :rtype AND resource_id = :rid", {:rtype => "Heading", :rid => h.id}])
    render :text => h.value
      
    #render :update do |page|   
    #end
  end

  def addNote
    n = Note.new(params[:note])
    addElement(n){render :partial=>'elements_list',:locals=>{:page=>@page}}
  end
  
  def updateNote
    #this method will probably serve as a minor controller for parsing wiki text out of the note,
    #then returning the real thing to the server.  If the note contains no wiki widgets, it will just return
    #text, otherwise, I will probably have to generate something on the fly to send back. 
    #partials may not work here.
    n = Note.find(params[:id])
    n.data = params[:value]
    n.save
    render :text => n.data
    
  end
  
  def addElement(el)
    @page = Page.find(params[:id])
    @page.add_element(el)
    yield
  end
  

  def moveElement
  end

  def addRow
  end

  def addCell
  end

  def runTable
  end

  def runPage
  end

  def runSuite
  end

end

class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.integer :position
      t.integer :page_id
      t.timestamps
    end
    
    execute "alter table elements
           add constraint fk_elements_pages
           foreign key (page_id) references pages(id)"
  end

  def self.down
    drop_table :elements
  end
end

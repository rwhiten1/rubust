class CreateVariables < ActiveRecord::Migration
  def self.up
    create_table :variables do |t|
      t.integer :page_id
      t.string :name
      t.string :value

      t.timestamps
    end
    
    #establish foreign key relationship with pages table
    execute "alter table variables
           add constraint fk_variables_pages
           foreign key (page_id) references pages(id)"
  end

  def self.down
    drop_table :variables
  end
end

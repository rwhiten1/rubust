class AddPolymorphism < ActiveRecord::Migration
  def self.up
    #add columns to the elements table
    #add_column :elements, :resource_id, :integer, :null => false
    #add_column :elements, :resource_type, :string, :null => false
    
    #execute "ALTER TABLE cells DROP FOREIGN KEY `fk_cells_test_tables`"
    #drop and recreate the notes, tables, and headings tables
    drop_table :notes
    drop_table :test_tables
    drop_table :headings
    
    #recreate the notes table
    create_table :notes do |t|
      t.text :data
      t.timestamps
    end
    
    #recreate the test_tables table
     create_table :test_tables do |t|
      t.string :name
      t.string :fixture
      t.integer :rows
      t.timestamps
    end
    
    #recreate the headings table
    create_table :headings do |t|
      t.string :value
      t.integer :size
      t.timestamps
    end
    
    #add the foreign key back to the test_tables table from the cells table
    execute "alter table cells add constraint fk_cells_test_tables
           foreign key (test_table_id) references test_tables(id)"
    
  end

  
  def self.down
    
  end
  
end

class CreateTestTables < ActiveRecord::Migration
  def self.up
    create_table :test_tables do |t|
      t.integer :element_id
      t.string :name
      t.string :fixture
      t.integer :rows

      t.timestamps
    end
    
    execute "alter table test_tables
           add constraint fk_test_tables_elements
           foreign key (element_id) references elements(id)"
  end

  def self.down
    drop_table :test_tables
  end
end

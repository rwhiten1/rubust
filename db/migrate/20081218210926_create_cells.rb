class CreateCells < ActiveRecord::Migration
  def self.up
    create_table :cells do |t|
      t.integer :test_table_id
      t.string :data
      t.integer :row
      t.integer :col

      t.timestamps
    end
    
    execute "alter table cells add constraint fk_cells_test_tables
           foreign key (test_table_id) references test_tables(id)"
    
  end

  def self.down
    drop_table :cells
  end
end

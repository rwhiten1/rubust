class LinkCellsToFixtureSheets < ActiveRecord::Migration
  def self.up
   #execute "ALTER TABLE cells DROP FOREIGN KEY `fk_cells_test_tables`"
  #remove_column :cells, :test_table_id
  #add_column :cells, :fixture_sheets_id, :integer
  remove_column :cells, :fixture_sheets_id
  add_column :cells, :fixture_sheet_id, :integer
   execute "alter table cells add constraint fk_cells_fixture_sheets
           foreign key (fixture_sheet_id) references fixture_sheets(id)"
    
  end

  def self.down
  execute "ALTER TABLE cells DROP FOREIGN KEY `fk_cells_fixture_sheets`"
  remove_column :cells, :fixture_sheets_id
  add_column :cells, :test_tables_id, :integer
  execute "alter table cells add constraint fk_cells_test_tables
           foreign key (test_table_id) references test_tables(id)"
    
  end
end

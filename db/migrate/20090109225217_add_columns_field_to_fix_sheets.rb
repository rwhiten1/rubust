class AddColumnsFieldToFixSheets < ActiveRecord::Migration
  def self.up
    add_column :fixture_sheets, :columns, :integer
  end

  def self.down
    remove_column :fixture_sheets, :columns
  end
end

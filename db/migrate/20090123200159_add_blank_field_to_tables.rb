class AddBlankFieldToTables < ActiveRecord::Migration
  def self.up
    add_column :fixture_sheets, :is_blank, :boolean
  end

  def self.down
    remove_column :fixture_sheets, :is_blank
  end
end

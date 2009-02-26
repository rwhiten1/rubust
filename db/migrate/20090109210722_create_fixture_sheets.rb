class CreateFixtureSheets < ActiveRecord::Migration
  def self.up
    create_table :fixture_sheets do |t|
      t.string :name
      t.string :fixture
      t.integer :rows

      t.timestamps
    end
  
  end

  def self.down
    drop_table :fixture_sheets
  end
end

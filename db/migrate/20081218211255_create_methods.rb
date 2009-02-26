class CreateMethods < ActiveRecord::Migration
  def self.up
    create_table :methods do |t|
      t.integer :fixture_id
      t.string :template

      t.timestamps
    end
    
    execute "alter table methods add constraint fk_methods_fixtures
           foreign key (fixture_id) references fixtures(id)"
  end

  def self.down
    drop_table :methods
  end
end

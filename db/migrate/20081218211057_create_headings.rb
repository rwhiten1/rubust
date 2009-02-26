class CreateHeadings < ActiveRecord::Migration
  def self.up
    create_table :headings do |t|
      t.integer :element_id
      t.string :value
      t.integer :size

      t.timestamps
    end
    
    execute "alter table headings add constraint fk_headings_elements
           foreign key (element_id) references elements(id)"
  end

  def self.down
    drop_table :headings
  end
end

class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :element_id
      t.text :data

      t.timestamps
    end
    
    execute "alter table notes
           add constraint fk_notes_elements
           foreign key (element_id) references elements(id)"
  end

  def self.down
    drop_table :notes
  end
end

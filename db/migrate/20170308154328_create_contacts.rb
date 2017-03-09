class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.text :about
      t.timestamps
      t.references :author
      t.references :project
    end
  end
end
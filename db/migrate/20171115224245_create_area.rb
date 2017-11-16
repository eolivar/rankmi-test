class CreateArea < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
    	t.string :name
      t.float :note
      t.references :parent, index: true

      t.timestamps
    end
  end
end

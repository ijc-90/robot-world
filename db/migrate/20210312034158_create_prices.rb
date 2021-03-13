class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.integer :year
      t.integer :model_id
      t.float :price

      t.timestamps
    end
  end
end

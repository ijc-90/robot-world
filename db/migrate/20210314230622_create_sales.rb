class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :car_id
      t.float :price

      t.timestamps
    end
  end
end

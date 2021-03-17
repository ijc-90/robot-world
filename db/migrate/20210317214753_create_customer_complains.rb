class CreateCustomerComplains < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_complains do |t|
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end

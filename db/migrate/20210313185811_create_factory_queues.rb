class CreateFactoryQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :factory_queues do |t|
      t.string :type
      t.integer :car_id
      t.integer :order_id
      t.boolean :processed

      t.timestamps
    end
  end
end

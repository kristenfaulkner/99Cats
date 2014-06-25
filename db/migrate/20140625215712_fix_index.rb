class FixIndex < ActiveRecord::Migration
  def change
    remove_index :cat_rental_requests, [:cat_id, :start_date]
    add_index :cat_rental_requests, :cat_id
  end
end

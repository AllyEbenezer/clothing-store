class AddAddressesToOrder < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :shipping_address, :string
    add_column :orders, :billing_address, :string
  end
end

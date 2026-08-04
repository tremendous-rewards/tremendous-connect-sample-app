class AddKybAddressLine2ToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :kyb_address_line2, :string
  end
end

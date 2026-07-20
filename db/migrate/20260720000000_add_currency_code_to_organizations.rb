class AddCurrencyCodeToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :currency_code, :string
  end
end

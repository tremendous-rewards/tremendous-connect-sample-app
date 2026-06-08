class AddKybFieldsToOrganizations < ActiveRecord::Migration[8.0]
  def change
    # Optional KYB pass-through fields. When provided, these are sent to
    # Tremendous as the `kyb` object on POST /connected_organizations, which
    # pre-fills the end client's onboarding form. All fields are optional.
    add_column :organizations, :kyb_company_name, :string
    add_column :organizations, :kyb_doing_business_as, :string
    add_column :organizations, :kyb_company_structure, :string
    add_column :organizations, :kyb_company_registration_number, :string
    add_column :organizations, :kyb_address_line1, :string
    add_column :organizations, :kyb_address_city, :string
    add_column :organizations, :kyb_address_state, :string
    add_column :organizations, :kyb_address_zip, :string
    add_column :organizations, :kyb_country_code, :string
    add_column :organizations, :kyb_website_url, :string
  end
end

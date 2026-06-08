class Organization < ActiveRecord::Base
  validates :name, presence: true

  # Assembles the optional `kyb` pass-through object sent to Tremendous on
  # POST /connected_organizations. Only non-blank fields are included, so the
  # object is fully optional — returns nil when no KYB data was provided, in
  # which case the request omits `kyb` entirely and the end client fills in the
  # onboarding form from scratch.
  def prefilled_kyb_details
    address = {
      line1: kyb_address_line1,
      city: kyb_address_city,
      state: kyb_address_state,
      zip: kyb_address_zip
    }.compact_blank

    {
      company_name: kyb_company_name,
      doing_business_as: kyb_doing_business_as,
      company_structure: kyb_company_structure,
      company_registration_number: kyb_company_registration_number,
      country_code: kyb_country_code,
      website_url: kyb_website_url,
      address: address.presence
    }.compact_blank.presence
  end
end

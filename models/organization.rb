class Organization < ActiveRecord::Base
  # CAD is intentionally included for testing the API's validation-error path;
  # Tremendous only supports USD, GBP, and EUR as explicit currency codes.
  CURRENCY_CODES = %w[USD GBP EUR CAD].freeze

  normalizes :currency_code, with: ->(code) { code.presence }

  validates :name, presence: true
  validates :currency_code, inclusion: { in: CURRENCY_CODES }, allow_blank: true

  # Assembles the optional `kyb_prefill` pass-through object sent to Tremendous
  # on POST /connected_organizations. Only non-blank fields are included, so the
  # object is fully optional — returns nil when no KYB data was provided, in
  # which case the request omits `kyb_prefill` entirely and the end client fills
  # in the onboarding form from scratch.
  def kyb_prefill_details
    {
      company_name: kyb_company_name,
      doing_business_as: kyb_doing_business_as,
      company_structure: kyb_company_structure,
      company_registration_number: kyb_company_registration_number,
      country_code: kyb_country_code,
      website_url: kyb_website_url,
      address_1: kyb_address_line1,
      address_2: kyb_address_line2,
      city: kyb_address_city,
      state: kyb_address_state,
      postal_code: kyb_address_zip
    }.compact_blank.presence
  end
end

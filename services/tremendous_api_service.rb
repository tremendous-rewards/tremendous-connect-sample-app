require 'httparty'

# Tremendous API Service
class TremendousApiService
  include HTTParty
  base_uri ENV["TREMENDOUS_API_URL"]

  def self.create_connected_organization(kyb_prefill: nil, currency_code: nil)
    body = { client_id: ENV["OAUTH_CLIENT_ID"] }
    # Optional KYB pass-through: when the platform already collected KYB on its
    # end client, forward it so the onboarding form is prefilled. Omitted
    # entirely when no KYB data is available.
    body[:kyb_prefill] = kyb_prefill if kyb_prefill
    body[:currency_code] = currency_code unless currency_code.to_s.empty?

    handle_response(
      post(
        "/connected_organizations",
        headers: headers,
        body: body.to_json
      )
    )
  end

  def self.create_connected_organization_member(
    connected_organization_id:,
    external_email:,
    external_name:
  )
    handle_response(
      post(
        "/connected_organization_members",
        headers: headers,
        body: {
          connected_organization_id: connected_organization_id,
          external_email: external_email,
          external_name: external_name
        }.to_json
      )
    )
  end

  def self.create_connected_organization_member_session(connected_organization_member_id:, return_url:)
    handle_response(
      post(
        "/connected_organization_members/#{connected_organization_member_id}/sessions",
        headers: headers,
        body: {
          return_url: return_url
        }.to_json
      )
    )
  end

  class << self
    private

    def headers
      {
        "Authorization" => "Bearer #{ENV["TREMENDOUS_API_KEY"]}",
        "Content-Type" => "application/json"
      }
    end

    def handle_response(response)
      raise "API Error: #{response.code} - #{response.body}" unless response.success?

      response.parsed_response
    end
  end
end

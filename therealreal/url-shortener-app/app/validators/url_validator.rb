require "net/http"

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      response = Net::HTTP.get_response(URI.parse(URI.encode(value)))
    rescue Errno::ECONNREFUSED
      record.errors.add(:long_url, "is malformed")
    end
  end
end
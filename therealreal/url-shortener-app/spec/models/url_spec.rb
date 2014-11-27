require 'rails_helper'

RSpec.describe Url, :type => :model do
  describe "#short_url" do
    it "appends base url to the key" do
      url = Url.create({long_url: 'http://www.yahoo.com'})
      expect(url.short_url).to match(/^http:\/\/aqueous-brook-6980.herokuapp.com\/.*/)
    end
  end
  
  describe "#generate_key" do
    it "creates a 6 character unique key" do
      url1 = Url.create({long_url: 'http://www.yahoo.com'})
      expect(url1.key.length).to eq(6)
      sleep 1
      url2 = Url.create({long_url: 'http://www.google.com'})     
      expect(url2.key.length).to eq(6)
      expect(url1.key).not_to eq(url2.key)
    end
  end
  
  describe "#ensure_protocol" do
    it "appends http:// to the url if protocol is missing" do
      url = Url.create({long_url: 'yahoo.com'})
      expect(url.long_url).to match(/^http:\/\/.*/)
    end
  end
end

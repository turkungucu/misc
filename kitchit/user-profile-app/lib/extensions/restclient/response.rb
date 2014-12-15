module RestClient
  module Response
    def success?
      code >= 200 && code < 300
    end
  end
end
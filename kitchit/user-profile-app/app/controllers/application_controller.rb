class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def api_url
    base = ENV['BASE_API_URL'] || "http://localhost:3000"
    version = ENV['API_VERSION_PATH'] || 'api/v1'
    [base, version].join('/')
  end
end

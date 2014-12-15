require 'rest_client'

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit]
  before_action :persist_profile, only: [:create, :update]

  # GET /profiles
  def index
    response = RestClient.get "#{base_api_url}/api/v1/profiles"
    @profiles = JSON.parse(response).each_with_object([]) {|j, a| a << Profile.new(j) }
  end

  # GET /profiles/1
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  def create
    if @profile
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /profiles/:id
  def update
    if @profile
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    response = RestClient.get "#{base_api_url}/api/v1/profile/#{params[:id]}"
    @profile = Profile.new(JSON.parse(response))
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.require(:profile).permit(:name, :email, :tagline, :avatar)
  end
  
  def base_api_url
    ENV['BASE_API_URL'] || "http://localhost:3000"
  end
  
  def persist_profile
    file = profile_params.delete :avatar
    profile_response = RestClient.post "#{base_api_url}/api/v1/profile/update", params
    
    if profile_response.success? 
      @profile = Profile.new(profile_params)
      
      # persist the avatar
      if file
        image_response = RestClient.post("#{base_api_url}/api/v1/avatar/upload", {
          image: {avatar: File.new(file.path, 'rb'), profile_id: @profile.id}
        })
      end
    end
  end
end

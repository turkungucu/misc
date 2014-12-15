require 'rest_client'

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit]
  before_action :persist_profile, only: [:create, :update]

  # GET /profiles
  def index
    response = RestClient.get "#{api_url}/profiles"
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
  
  # GET /avatar/:id
  def avatar
     # app-level default is to get thumbnail
     response = RestClient.get "#{api_url}/avatar/#{params[:id]}", { params: { size: (params[:size] || 'thumb') } }
     redirect_to JSON.parse(response)["url"]
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    response = RestClient.get "#{api_url}/profile/#{params[:id]}"
    @profile = Profile.new(JSON.parse(response))
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.require(:profile).permit(:name, :email, :tagline, :avatar)
  end
  
  def persist_profile
    file = profile_params.delete :avatar
    profile_response = RestClient.post "#{api_url}/profile/update", params
    
    if profile_response.success?
      # build transient object from params
      @profile = Profile.new(profile_params)
      @profile.id = params[:id] if params[:id]

      # persist the avatar
      if file
        
        f= File.new(file.path, 'rb')
        f.instance_eval do
          def content_type
            'image/jpeg'
          end
        end
        
        image_response = RestClient::Request.new(
          :method => "post",
          :url => "#{api_url}/avatar/upload",       
          :payload => {'image[avatar]' => f, 'image[profile_id]' => @profile.id},
          :headers => { :accept => :json, :content_type => :json}
        ).execute
        
        @profile.avatar_id = JSON.parse(image_response)[:id]
        
        # image_response = RestClient.post("#{base_api_url}/api/v1/avatar/upload", 
          # {image: {avatar: File.new(file.path, 'rb'), profile_id: @profile.id}}, 
          # content_type: 'image/jpeg', accept: :json
        # )
      end
    end
  end
end

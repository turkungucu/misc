module Api
  module V1
    class ProfilesController < ApplicationController
      # GET /profiles
      def index
        @profiles = Profile.all
        output = @profiles.each_with_object([]) {|p, a| a << serialize(p)}
        render json: output
      end
    
      # GET /profile/:id
      def show
        @profile = Profile.find_by_public_id(params[:id])
    
        render json: serialize(@profile)
      end
      
      # GET /profile/search
      def search
        wildcard_search = "%#{params[:term]}%"
        @profiles = Profile.where("name ILIKE ? OR email ILIKE ? OR tagline ILIKE ? ", wildcard_search, wildcard_search, wildcard_search)
        output = @profiles.each_with_object([]) {|p, a| a << serialize(p)}
        
        render json: output
      end
    
      # POST /profile/update
      def update
        @profile = if params[:id]
          Profile.find_by_public_id(params[:id])
        else
          Profile.new(profile_params)
        end

        if @profile.new_record? && @profile.save
          render json: serialize(@profile), status: :created, location: api_v1_profile_path(@profile.public_id)
        elsif @profile.update(profile_params)
          head :no_content
        else
          render json: @profile.errors, status: :unprocessable_entity
        end
      end
    
      private
        
      def profile_params
        params.require(:profile).permit(:name, :email, :tagline)
      end
      
      # Whitelisting attributes to return. DB id is replaced by public_id.
      def serialize(profile)
        h = {id: profile.public_id, name: profile.name, email: profile.email, tagline: profile.tagline}
        h[:avatar_id] = profile.image.public_id if profile.image
        h
      end
    end
  end
end

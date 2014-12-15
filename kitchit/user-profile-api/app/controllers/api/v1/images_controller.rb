module Api
  module V1
    class ImagesController < ApplicationController
      # GET /avatar/:id
      def show
        @image = Image.find_by_public_id(params[:id])
        # if there is no size specified, get the original image
        size = (params[:size] && params[:size].to_sym) || :original
        
        render json: { url: @image.avatar.url(size) }
      end
    
      # POST /avatar/upload
      def upload
        @profile = Profile.find_by_public_id(image_params.delete(:profile_id))
        # replacing avatar if one already exists
        @profile.image.destroy if @profile.image
        @image = @profile.build_image(image_params)

        if @image.save
          render json: serialize(@image), status: :created, location: api_v1_avatar_path(@image.public_id)
        else
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    
      private
        
      def image_params
        params.require(:image).permit(:profile_id, :avatar)
      end
      
      # Whitelisting attributes to return. DB id is replaced by public_id.
      def serialize(image)
        {id: image.public_id}
      end
    end
  end
end

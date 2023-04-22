class PropertiesController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]

  def index
      properties = Property.all
      render json: properties.as_json(methods: :photo_urls), status: :ok
  end

  def create
    property = Property.new(property_params)
    if property.save
      photos = Array.wrap(params[:photos])
      if photos.present?
        photos.each do |photo|
          image = Cloudinary::Uploader.upload(photo)
          property.photos.create(image: image["url"])
        end
      end
      current_user.properties << property
      render json: property.as_json(methods: :photo_urls), status: :created
    else
      respond_unauthorized("Error! the property could not be created")
    end
  end

  def update
    property = Property.find(params[:id])
    property = current_user.properties.find(params[:id])

    if property.update(property_params)
      photos = Array.wrap(params[:photos])
      if photos.present?
        photos.each do |photo|
          image = Cloudinary::Uploader.upload(photo)
          property.photos.create(image: image["url"])
        end
      end
      render json: property.as_json(methods: :photo_urls), status: :ok
    else
      respond_unauthorized("Error! the property could not be updated")
    end
    rescue ActiveRecord::RecordNotFound
      respond_unauthorized("Error! there is no property id associated with this user")
  end

  def show
    property = Property.find(params[:id])
    if property
      users = property.users.with_role('landlord')
      users_json = users.map {|user| { id: user.id, name: user.name, email: user.email, phone: user.phone, role: user.role } }
      user_json = users_json.first
      render json: { property: property.as_json(methods: :photo_urls), landlord_user: user_json }, status: :ok
    else
      respond_unauthorized("Error! the property could not be found")
    end
  end

  def destroy
    property = Property.find(params[:id])
    property.photos.each do |photo|
      Cloudinary::Uploader.destroy(photo.image.match(/(?<=\/)[^\/]+(?=\.[^.]*$)/)[0])
      photo.destroy
    end
    if property
      property.destroy
      head :no_content
    else
      respond_unauthorized("Error! the property could not be deleted")
    end
  end

  private

  def property_params
    params.permit(:address, :type_operation, :monthly_rent, :maintanance, :price, :type_property, :bedrooms, :bathrooms, :area, :pets_allowed, :status, :description, :photos )
  end
end

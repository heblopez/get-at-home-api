class FavoritesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    favorite_users_props = user.users_props.where(favorite: true)
    render json: favorite_users_props, status: :ok
  end

  def create
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    if user.role == "home_seeker"
      favorite = user.users_props.create(property_id: property.id, favorite: true)
      render json: favorite, status: :created
    else
      render json: { error: "Only a home_seeker user can mark properties as favorites."}
    end
  end

  def update
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    favorite = user.users_props.where(property_id: property.id)

    if favorite.exists?(favorite: [nil, false])
      favorite.update(favorite: true)
      render json: favorite, status: :ok
    else
      favorite.update(favorite: false) 
      render json: favorite, status: :ok
    end
  end
end
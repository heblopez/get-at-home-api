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

  def destroy
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    # favorite = user.users_props.where(property_id: property.id)
    favorite = UsersProp.find_by(user_id: user.id, property_id: property.id, favorite: true)

    if favorite
      favorite.destroy
      head :no_content
    else
      render json: { error: "Favorite could not be deleted" }
    end
  end
end
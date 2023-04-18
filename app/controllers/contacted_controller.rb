class ContactedController < ApplicationController

  def index
    user = User.find(params[:user_id])
    contacted_users_props = user.users_props.where(contacted: true)
    render json: contacted_users_props, status: :ok
  end

  def create
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    if user.role == "home_seeker"
      contacted = user.users_props.create(property_id: property.id, contacted: true)
      render json: contacted, status: :created
    else
      render json: { error: "Only a home_seeker user can mark properties as contacted."}
    end
  end

  def update
    user = User.find(params[:user_id])
    property = Property.find(params[:id])
    contacted = user.users_props.where(property_id: property.id)

    if contacted.exists?(contacted: [nil, false])
      contacted.update(contacted: true)
      render json: contacted, status: :ok
    end
  end
end
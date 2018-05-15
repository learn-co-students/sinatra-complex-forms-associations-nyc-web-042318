class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if params["pet"]["owner_id"]
      @pet.owner=Owner.find_by(id: params["pet"]["owner_id"])
    else
      @owner=Owner.create(name: params["owner"]["name"])
      @pet.owner=@owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    erb :"/pets/edit"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if params["owner"]["name"] != ""
      @owner=Owner.create(name: params["owner"]["name"])
      @pet.update(owner: @owner)
    else
      #elsif params["pet"]["owner_id"]
      @owner=Owner.find_by(id: params["pet"]["owner_id"])
      @pet.update(owner: @owner)
    end

    # if !params["owner"]["name"].empty?
    #   @pet.owner=Owner.create(name: params["owner"]["name"])
    # end
    redirect to "pets/#{@pet.id}"
  end
end

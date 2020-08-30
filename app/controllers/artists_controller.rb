class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    
    @entities = @artists;
    @attributes = [
      {sym: :name, hr_name: "Name", is_link_attribute: true}
    ]
  end
  
  def edit
    @artist = Artist.find(params[:id])
  end
  
  def update
    @artist = Artist.find(params[:id])
      
    if @artist.update_attributes artist_params
      redirect_to action: "index"
    else
      # TODO
    end
  end
  
  def show
    @artist = Artist.find(params[:id])
    @master_releases = MasterRelease.where(artist_id: params[:id])
      
    @attributes = [
      {sym: :title, hr_name: "Title", is_link_attribute: true}
    ]
    
    @entities = @master_releases
      
    session[:artist_id] = @artist.id
  end
  
  def new
    @artist = Artist.new
  end
  
  def destroy
    @artist = Artist.find(params[:id])
    @artist.delete

    redirect_to action: "index"
  end
  
  def create
    @artist = Artist.new artist_params
    
    if @artist.save
      redirect_to action: "index"
    else
      # TODO
    end
  end
  
  private
  
  def artist_params
    params.require(:artist).permit(:name)
  end
end

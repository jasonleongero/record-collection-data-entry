class MasterReleasesController < ApplicationController
  def new
    @master_release = MasterRelease.new
    
    @artist = Artist.find(params[:artist_id])
  end
  
  def edit
    @master_release = MasterRelease.find(params[:id])
  end
  
  def update
    @master_release = MasterRelease.find(params[:id])
      
    artist = @master_release.artist
          
    if @master_release.update_attributes master_release_params
      redirect_to(artist_path id: artist.id)
    else
      # TODO
    end
  end
  
  def show
    @master_release = MasterRelease.find(params[:id])
    @artist = @master_release.artist
    
    @releases = Release.where(master_release_id: params[:id])
    
    @entities = @releases  
      
    @attributes = [
      {sym: :title, hr_name: "Title", is_link_attribute: true},
      {sym: :formats_description, hr_name: "Format"},
      {sym: :catalog_number, hr_name: "Catalog #"},
      {sym: :record_label_name, hr_name: "Record Label"},
      {sym: :country_name, hr_name: "Country"},
      {sym: :release_date, hr_name: "Release Date"}
    ]
  end
  
  def destroy
    @master_release = MasterRelease.find(params[:id])
      
    artist = @master_release.artist
      
    @master_release.delete
    
    redirect_to(artist_path id: artist.id)
  end
  
  def create
    artist_id = session[:artist_id]
    
    params = master_release_params    
    params[:artist_id] = artist_id
      
    @master_release = MasterRelease.new params
    
    if @master_release.save
      redirect_to(artist_path id: artist_id)
    else
      # TODO
    end
  end
  
  private
  
  def master_release_params
    params.require(:master_release).permit(:title)
  end
end

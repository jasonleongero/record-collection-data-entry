class ReleasesController < ApplicationController
  def new
    @release = Release.new
    
    @master_release = MasterRelease.find(params[:master_release_id])
    @artist = @master_release.artist
    
    @countries = Country.all.map { |country| [country.name, country.country_iso_code] }
    @record_labels = RecordLabel.all.map { |label| [label.name, label.record_label_id] }
  end
  
  def edit
    @release = Release.find(params[:id])
      
    @master_release = @release.master_release
    @artist = @master_release.artist
    
    @countries = Country.all.map { |country| [country.name, country.country_iso_code] }
    @record_labels = RecordLabel.all.map { |label| [label.name, label.record_label_id] }
  end
  
  def update
    @release = Release.find(params[:id])
      
    master_release = @release.master_release
              
    if @release.update_attributes release_params
      redirect_to(master_release_path id: master_release.id)
    else
      # TODO
    end
  end
  
  def show
    @release = Release.find(params[:id])
    @artist = @release.master_release.artist
    @master_release = @release.master_release
    @tracks = @release.tracks
    @formats = @release.formats
    @images = @release.images
    @primary_image = @release.primary_image
  end
  
  def destroy
    @release = Release.find(params[:id])
      
    master_release = @release.master_release
      
    @release.delete
        
    redirect_to(master_release_path id: master_release.id)
  end
  
  def create
    params = release_params
    
    @release = Release.new params
    
    if @release.save
      redirect_to(master_release_path id: params[:master_release_id])
    else
      # TODO
    end
  end
  
  private
  
  def release_params
    allowed_parameters = [
      :title,
      :catalog_number,
      :release_year,
      :release_month,
      :release_day,
      :country_iso_code,
      :record_label_id,
      :master_release_id,
      :is_key
    ]
    
    params.require(:release).permit(*allowed_parameters)
  end
end

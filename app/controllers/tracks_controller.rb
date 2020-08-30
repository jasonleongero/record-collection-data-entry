class TracksController < ApplicationController
  def create    
    @release_id = params[:release_id]
      
    existing_tracks = (Release.find @release_id).tracks

    number_of_tracks_submitted = params[:track_title] ? params[:track_title].length : 0
    number_of_existing_tracks = existing_tracks.length
    
    [number_of_tracks_submitted, number_of_existing_tracks].max.times do |index|      
      if index < number_of_existing_tracks && index < number_of_tracks_submitted
        existing_tracks[index].update_attributes(get_params_from_submitted_track index)
      elsif index >= number_of_existing_tracks && index < number_of_tracks_submitted
        (Track.new (get_params_from_submitted_track index)).save
      elsif index < number_of_existing_tracks && index >= number_of_tracks_submitted
        existing_tracks[index].destroy
      end
    end
    
    redirect_to release_path params[:release_id]
  end
  
  private
  
  def get_params_from_submitted_track index
    {
      release_id: @release_id,
      order: index,
      title: params[:track_title][index],
      track_number: params[:track_number][index],
      duration: duration_in_seconds(params[:track_minutes][index].to_i, params[:track_seconds][index].to_i)
    }
  end
  
  def track_params
    allowed_parameters = [
      :release_id,
      :order,
      :track_number,
      :title,
      :duration
    ]
      
    params.require(:track).permit(*allowed_parameters)
  end
  
  def duration_in_seconds minutes, seconds
    (minutes * 60) + seconds
  end
end
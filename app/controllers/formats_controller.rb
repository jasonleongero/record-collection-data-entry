class FormatsController < ApplicationController
  def create    
    @release_id = params[:release_id]
      
    existing_formats = (Release.find @release_id).formats

    number_of_formats_submitted = params[:format_name] ? params[:format_name].length : 0
    number_of_existing_formats = existing_formats.length
    
    [number_of_formats_submitted, number_of_existing_formats].max.times do |index|      
      if index < number_of_existing_formats && index < number_of_formats_submitted
        existing_formats[index].update_attributes(get_params_from_submitted_format index)
      elsif index >= number_of_existing_formats && index < number_of_formats_submitted
        (Format.new (get_params_from_submitted_format index)).save
      elsif index < number_of_existing_formats && index >= number_of_formats_submitted
        existing_formats[index].destroy
      end
    end
    
    redirect_to release_path params[:release_id]
  end
  
  private
  
  def get_params_from_submitted_format index
    {
      release_id: @release_id,
      format_name: params[:format_name][index],
      quantity: params[:format_quantity][index]
    }
  end
  
  def track_params
    allowed_parameters = [:release_id, :format_name, :quantity]
      
    params.require(:format).permit(*allowed_parameters)
  end
end
class RecordLabelsController < ApplicationController
  def index
    @record_labels = RecordLabel.all
  end
  
  def new
    @record_label = RecordLabel.new
  end
  
  def create
    @record_label = RecordLabel.new record_label_params
    
    if @record_label.save
      @record_labels = RecordLabel.all
      render 'index'
    else
      # test
    end
  end
  
  private
  
  def record_label_params
    params.require(:record_label).permit(:name)
  end
end

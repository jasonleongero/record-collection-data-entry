class ImagesController < ApplicationController
  IMAGES_BUCKET = 'jasongero-photos'
  
  def create    
    image_data = params[:post][:image].tempfile.read
    
    Aws.config.update({
      region: 'us-west-2',
      credentials: Aws::Credentials.new('', '')
    })
    
    s3 = Aws::S3::Client.new(region: 'us-west-2')
    
    image_file_name = get_image_file_name
    image_url = get_image_url image_file_name
    
    s3.put_object({
      body: image_data,
      bucket: 'jasongero-photos',
      key: image_file_name,
      acl: 'public-read'
    })
    
    release = Release.find params[:release_id]
    number_of_images = release.images.count
    
    image = Image.new({
      release_id: params[:release_id],
      image_url: image_url,
      is_primary: release.images.count == 0
    })
    
    image.save
  end
  
  private
  
  def get_image_file_name
    'release_image_' + SecureRandom.uuid + '.png'
  end
  
  def get_image_url file_name
    "http://#{IMAGES_BUCKET}.s3-us-west-2.amazonaws.com/#{file_name}"
  end
end

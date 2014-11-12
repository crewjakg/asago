class MemberImage < ActiveRecord::Base

  belongs_to :member

  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif",
			    "image/png" => "png" }

  def extention
	IMAGE_TYPES[content_type]
  end

  validate :check_image

  attr_reader :uploaded_image


  def uploaded_image=(image)
	self.content_type = convert_content_type(image.content_type)
	self.data = image.read
	@uploaded_image = image
  end

  def check_image
  	if @uploaded_image
  	  if data.size > 64.kilobytes
  	  	errors.add(:uploaded_image, :too_big_image)
  	  end
  	  unless IMAGE_TYPES.has_key?(content_type)
  	  	errors.add(:uploaded_image, :invalid_image)
  	  end
  	end

  end


  private
  def convert_content_type(ctype)
	ctype = ctype.rstrip.downcase
	case ctype
	  when "image/pjpeg" then "image/jpeg"
	  when "image/jpg" then "image/jpeg"
	  when "image/x-peg" then "image/png"
	  else ctype
	end
  end


end
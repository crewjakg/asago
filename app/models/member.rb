class Member < ActiveRecord::Base

has_secure_password

has_one  :image, class_name: "MemberImage", dependent: :destroy
has_many :entries, dependent: :destroy
has_many :votes, dependent: :destroy
has_many :voted_entries, through: :votes, source: :entry

accepts_nested_attributes_for :image, allow_destroy: true
#accepts_nested_attributes_for :votes, allow_destroy: :true
#accepts_nested_attributes_for :voted_entries, allow_destroy: :true


require 'net/http'
require 'uri'

  #attr_accesor :password, :password_confirmation

  class << self

	def search(q)
		rel = order("number") #並び順指定　例 order('age ASC, created_at DESC')
		if query.present?
			rel = rel.where("name LIKE ? or full_name LIKE ?",
				  "%#{q}%","%#{q}%")
		else
			rel = rel.all
		end
	end

  end

	# 自分の記事ではなくて、１つの記事に1回も投票していなければtrueを返す
  def votable_for?(entry)
	entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end



 validates :number, presence: true,
 	numericality: { only_integer: true,
 				greater_than: 0, less_than: 100, allow_blanck: true },
 				uniqueness: true

validates :name, presence: true,
	format: { with: /\A[A-Za-z]\w*\z/, allow_blanck: true,
			  message: :invalid_member_name },
	length: { minimum: 2, maximum: 20, allow_blanck: true },
	uniqueness: { case_sensitive: false }

#validates :password, presence: { on: :create },
#          confirmation: { allow_blanck: true }

validate :check_email


private
def check_email
	if email.present?
		# if url_request(email) == false then
		# 	errors.add(email, 'E')
		# end
	else
		#errors.add(:email, :invlid)
	end
end

  def url_request(url, limit = 10)
		logger.debug("Hello, world!1")
    if limit == 0
      return false
    end
    begin
		logger.debug("Hello, world!2")
		uri = URI.parse(url)
		logger.debug("Hello, world!3")
		logger.debug(uri)
		logger.debug(uri.host)
		logger.debug(uri.port)
		# http = Net::HTTP.new(uri.host, uri.port)
		# logger.debug("Hello, world!4")
		# request = Net::HTTP::Get.new(uri.request_uri)
		# logger.debug(request)
		# logger.debug("Hello, world!5")
		# http.use_ssl = true
		# logger.debug("Hello, world!6")
		# res = http.start {
		# http.get(uri.request_uri)
		# }
		#response = http.request(request)
		#response.code             # => 301
		#response.body
		logger.debug("Hello, world!7")
		#res = Net::HTTP.get_response(URI(url))
		response = Net::HTTP.get_response(URI.parse(url))
		logger.debug("Hello, world!xx")
    rescue
		logger.debug("Hello, world! rescue")
      return false
    else
		logger.debug("Hello, world!4")
      case response
      when Net::HTTPSuccess
        return true
      when Net::HTTPRedirection
        url_request(response['location'], limit - 1)
      else
        return false
      end
    end
  end

end

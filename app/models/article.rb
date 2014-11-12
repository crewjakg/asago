class Article < ActiveRecord::Base

  class << self
	  def sidebar_articles(member, num)
	    readable_for(member).order("released_at DESC").limit(num)
    end
  end

    #バリデーションの前の処理
    before_validation :clear_expired_at

    validates :title, :body, :released_at, presence: true
    validates :title, length: { maximum: 200 }
    validate :check_expired_at

    scope :readable_for,
       ->(member){
         now = Time.current
         rel = where("released_at <= ? and (? < expired_at or " +
           "expired_at is NULL)", now, now)
         member.kind_of?(Member) ? rel : rel.where(member_only: false)
         }


  private

    def check_expired_at
      if expired_at && expired_at < released_at
        errors.add(:expired_at, :expired_at_too_old)
      end
    end

    def no_expiration
      expired_at.blank?
    end

    def no_expiration=(val)
      @no_expiration = val.in?([true, 1, "1"])
    end

    def clear_expired_at
      self.expired_at = nil if @no_expiration
    end
end

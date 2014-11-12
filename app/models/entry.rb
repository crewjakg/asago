class Entry < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member


  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  #attr_accessible :title, :body, :posted_at, :status

  #公開記事を取り出す
  scope :common, ->{ where(status: "public") }
  #公開記事と会員限定記事を取り出す
  scope :published, ->{ where("status <> ?", "draft") }
  #公開記事と会員限定記事、および会員自身の記事を取り出す
  scope :full, ->(member) { where("status <> ? or member_id = ?", "draft", member.id) }
  #common　と　full スコープを組み合わせ
  scope :readable_for,
     ->(member) { member.kind_of?(Member) ? full(member) : common }

  class << self
	def status_text(status)
		I18n.t("activerecord.attributes.entry.status_#{status}")
	end

	def sidebar_entries(member, num )
		readable_for(member).order("posted_at DESC").limit(num)
	end

	def status_options
		STATUS_VALUES.map { |status| [status_text(status),status] }
	end

  end

end

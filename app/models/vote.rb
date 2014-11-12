class Vote < ActiveRecord::Base

belongs_to :entry
belongs_to :member

#会員がエントリールールに合わない投票の場合は、エラーにする
validate do
  unless member && member.votable_for?(entry)
  	errors.add(:base, invalid)
  end
end


end

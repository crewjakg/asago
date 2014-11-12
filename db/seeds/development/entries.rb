# coding: utf-8

%w(Taro Jiro Hana).each do |name|
  member = Member.find_by_name(name)
  0.upto(9) do |idx|
  	entry = Entry.create(
  	  author: member,
  	  title: "野球観戦#{idx}",
  	  body: "今晩は久しぶりに神宮で野球観戦。内野B席の冗談に着席。\n先発はヤクルト館山、広島福井" +
  	  		"５回までは0対0の投手戦で、ヤクルトはノーヒット。6回に試合が動き出し、2点先行されます" +
  	  		"しかしその裏、畠山の満塁打に宮本のソロで大逆転！\nしかし7回に押本が大乱調、栗原に満塁打" +
  	  		"をお返しされてしまいました。",
  	  posted_at: 10.days.ago.advance(days: idx),
  	  status: %w(draft member_only public)[idx % 3]
  		)

    if idx == 7 || idx == 8
      %w(John Make Sophy).each do |name2|
        voter = Member.find_by_name(name2)
        #binding.pry
        voter.voted_entries << entry
      end
    end
  end

end
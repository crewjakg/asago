# coding: utf-8

0.upto(9) do |idx|
	Article.create(title: "練習試合の結果#{idx}" + (idx % 3 == 0 ? "☆" : ""),
		body: "Crewjaが4対2でxxxxに勝利。\n2回表、６番吉田の二塁打から７番木下、" +
		"８番木梨の連続タイムリーで２点先制。９回表、ランナー二塁で２点を挙げ、ダメ" +
		"押しした。\n投げては初先発の中本が７回を２失点に抑え、玉川、榎本とつないで" +
		"逃げ切った。",
		released_at: 8.days.ago.advance(days: idx),
		expired_at: 2.days.ago.advance(days: idx),
		member_only: (idx % 3 == 0)
	)
end
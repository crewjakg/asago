# coding: utf-8

class SessionsController < ApplicationController

def create
	# member = Member.authenticate(params[:name],params[:password])
	# if member

    member = Member.find_by_name params[:name]
    if member && member.authenticate(params[:password])
		session[:member_id] = member.id
	else
		flash.alert = "名前とパスワードが一致しません"
	end
	redirect_to params[:from] || :root
  end

def destroy
	session.delete(:member_id)
	redirect_to :root
end

end

# coding: utf-8

class MembersController < ApplicationController

before_filter :login_required

def index
	@members = Member.order("number").
		paginate(page: params[:page],per_page: 5)
end

def search
	@members = Member.search(params[:q]).
		paginate(page: params[:page],per_page: 5)
	render "index"
end

def show
	@member = Member.find(params[:id])
	if params[:format].in?(["jpg","png","gif"])
		send_image
	else
		render "members/show"
	end
end


private
def send_image
	if @member.image.present?
		send_data @member.image.data,
		  type: @member.image.content_type, disposition: "inline"
	else
		raise NotFound
	end
end


end


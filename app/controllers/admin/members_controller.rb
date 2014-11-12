# coding: utf-8

class Admin::MembersController < Admin::Base

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
end

def new
	@member = Member.new(birthday: Date.new(1980,1,1))
	@member.build_image
end

def edit
	@member = Member.find(params[:id])
	@member.build_image unless @member.image

end

def create
	@member = Member.new(member_params)
	if @member.save
		redirect_to [:admin, @member], notice: "会員を登録しました"
	else
		render "new"
	end
end

def update
	@member = Member.find(params[:id])
	#@member.assign_attributes(params[:member])
	if @member.update(member_params)
		redirect_to [:admin, @member], notice: "会員を更新しました"
	else
		render 'edit'
	end
end

def destroy
	@member = Member.find(params[:id])
	@member.destroy
	redirect_to :admin_members, notice: "会員を削除しました"
end


private
def member_params
    params.required(:member).permit(:number,:name,:full_name,:gender,:birthday,:email,:administrator,
 	                             :phone,:password,:password_confirmation,
 	                             image_attributes:[:uploaded_image,:_destroy,:id]
 	                             )
 #	                             voted_entries_attributes:[:entry_id,:_destroy,:id]

end

end


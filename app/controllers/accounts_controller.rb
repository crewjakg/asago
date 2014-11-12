#coding utf-8
class AccountsController < ApplicationController

  before_filter :login_required

def show
	@member = @current_member
end

def edit
	@member = @current_member
	@member.build_image unless @member.image

end

def update
	@member = @current_member
	if @member.update(member_params)
		redirect_to :account, notice: "アカウント情報を更新しました"
	else
		render 'edit'
	end
end


private
def member_params
 params.required(:member).permit(:name,:full_name,:gender,:birthday,:email,:phone,:password,:password_confirmation)
end


end

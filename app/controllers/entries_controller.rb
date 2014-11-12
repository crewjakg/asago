#coding utf-8

class EntriesController < ApplicationController

  before_filter :login_required, except: [:index, :show]


  def index
	if params[:member_id]
		@member = Member.find(params[:member_id])
		rel = @member.entries
	else
		rel = Entry
	end
	@entries = rel.readable_for(@current_member).
				order("posted_at DESC").
				paginate(page: params[:page], per_page: 5)
  end

  def show
  		@entry = Entry.readable_for(@current_member).find(params[:id])
  end

  def new
  		@entry = Entry.new(posted_at: Time.current)
  end

  def edit
  		@entry = @current_member.entries.find(params[:id])
  end

def create
	@entry = Entry.new(entry_params)
	@entry.author = @current_member
	if @entry.save
		redirect_to @entry, notice: "記事を作成しました"
	else
		render "new"
	end
end

def update
	@entry = @current_member.entries.find(params[:id])
	if @entry.update(entry_params)
		redirect_to @entry, notice: "記事を更新しました"
	else
		render 'edit'
	end
end

def destroy
	@entry = @current_member.entries.find(params[:id])
	@entry.destroy
	redirect_to [@current_member, :entries], notice: "記事を削除しました"
end

def like
	@entry = Entry.published.find(params[:id])
	@current_member.voted_entries << @entry
	redirect_to @entry, notice: "投票しました"
end

def voted
	@entries = @current_member.voted_entries.published.
				order("votes.created_at DESC").
				paginate(page: params[:page], per_page: 15)
end

def unlike
	@current_member.voted_entries.delete(Entry.find(params[:id]))

end



private
def entry_params
    params.required(:entry).permit(:member_id,:title,:body,:posted_at,:status)
end


end

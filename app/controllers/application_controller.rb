class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize

  class Forbidden < StandardError; end
  class NotFound < StandardError; end

  #例外が発生したときのエラー表示を独自で設定する
  if Rails.env.production? #本番モードの場合
    rescue_from Exception, with: :rescue_500
    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
  end

  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404

  def rescue_403(exception)
    render "errors/forbidden", status: 403, layout: "error"
  end

  def rescue_404(exception)
    render "errors/not_found", status: 404, layout: "error"
  end

  def rescue_500(exception)
    render "errors/internal_server_error", status: 500, layout: "error"
  end


  private
  def authorize
    if session[:member_id]
    	@current_member = Member.find_by_id(session[:member_id])
      session.delete(:member_id) unless @current_member
    end
  end

  def login_required
  	raise Forbidden unless @current_member
  end

end

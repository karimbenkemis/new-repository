class UsersController < ApplicationController
  before_action :validate_user, except: [:index]
  after_action :send_mail, except: [:index]

  def index
    case params[:status]
    when 'deleted'
      @users = User.inactivated
    when 'unarchived'
      @users = User.activated
    when 'archived'
      @users = User.archived
    else
      @users = User.all
    end

    render jsonapi: @users
  end

  def delete
    if @user_to_process
      @user_to_process.destroy
      @action = __method__.to_s
      render_success
    else
      render_error
    end
  end

  def archive
    if @user_to_process
      @user_to_process.archive
      @action = __method__.to_s
      render_success
    else
      render_error
    end
  end

  def unarchive
    if @user_to_process
      @user_to_process.unarchive
      @action = __method__.to_s
      render_success
    else
      render_error
    end
  end

  def validate_user
    render json: { message: 'invalid user id' }, status: :unauthorized if @user.id.to_s == params[:id]
    @user_to_process = User.find_by(id: params[:id])
  end

  def send_mail
    UserNotifierMailer.send_confirmation_email(@user_to_process.email, @action + 'd').deliver
  end

  private

  def render_success
    render body: nil, status: :no_content
    Rails.logger.info "action: #{request.method}, url: #{request.url} user: #{@user.email}"
  end

  def render_error
    render json: { error: 'Invalid user id' }, status: :unprocessable_entity
  end
end

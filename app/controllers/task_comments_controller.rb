class TaskCommentsController < ApplicationController
  before_action :auth_user!

  def new
    @task_comment = TaskComment.new
  end

  def create
    @task_comment                = TaskComment.new(task_comment_params)
    @task_comment.admin_task_id  = params[:admin_task_id]
    @task_comment.user_id        = current_user.id

    respond_to do |format|
      if @task_comment.save
        format.html { redirect_to edit_part_path, notice: 'Admin task was successfully created.' }
      else
        format.html { redirect_to :back, notice: 'Saving admin task failed' }
      end
    end
  end

  private

    def task_comment_params
      params.require(:task_comment).permit(:comment)
    end
end
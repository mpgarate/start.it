class TaskCommentsController < ApplicationController

  def create
    @task_comment         = TaskComment.new(task_comment_params)
    @task_comment.kind_id = params[:kind_id]
    @task_comment.kind    = params[:kind]
    @task_comment.user_id = current_user.id

    respond_to do |format|
      if @task_comment.save
        format.html { redirect_to :back, notice: 'Comment successfully created.' }
      else
        format.html { redirect_to :back, notice: 'There has been an error creating your comment. Please try again.' }
      end
    end
  end

  private

    def task_comment_params
      params.require(:task_comment).permit(:comment)
    end
end

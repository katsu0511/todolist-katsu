class CommentsController < ApplicationController
  before_action :forbid_unuser, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user_comment, only: [:edit, :update, :destroy]

  def show
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.build
  end

  def create
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to board_task_path(board, task), notice: 'successfully saved a comment!'
    else
      flash.now[:error] = 'failed to save'
      render :new
    end
  end

  def edit
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:id])
  end

  def update
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to board_task_path(board, task), notice: 'successfully updated a comment!'
    else
      flash.now[:error] = 'failed to update'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    comment = task.comments.find(params[:id])
    comment.destroy!
    redirect_to board_task_path(board, task), notice: 'successfully deleted a comment!'
  end

  private
  def authenticate_user_comment
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    comment = task.comments.find(params[:id])
    if current_user.id != comment.user_id
      redirect_to board_task_comment_path(board, task, comment), notice: 'You don\'t have right'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end

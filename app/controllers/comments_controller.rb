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
    @comment = task.comments.build(user_id: current_user.id, content: params[:content])

    if @comment.save
      flash[:notice] = 'successfully saved comment!'
      redirect_to board_task_path(board, task)
    else
      flash[:notice] = 'failed to save comment'
      render("comments/new")
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
    @comment.content = params[:content]

    if @comment.save
      flash[:notice] = 'successfully updated comment!'
      redirect_to board_task_path(board, task)
    else
      flash[:notice] = 'failed to update comment'
      render("comments/edit")
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = 'successfully deleted comment!'
      redirect_to board_task_path(board, task)
    else
      flash[:notice] = 'failed to delete comment'
      render("comments/show")
    end
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

end

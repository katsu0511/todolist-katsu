class CommentsController < ApplicationController

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

end

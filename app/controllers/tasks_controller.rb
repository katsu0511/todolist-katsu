class TasksController < ApplicationController

  def show
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(user_id: current_user.id, title: params[:title], content: params[:content])
    if @task.save
      redirect_to board_path(board), notice: 'added a task'
    else
      flash[:notice] = 'failed to add a task'
      render("tasks/new")
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

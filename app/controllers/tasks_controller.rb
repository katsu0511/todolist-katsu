class TasksController < ApplicationController
  before_action :forbid_unuser, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user_task, only: [:edit, :update, :destroy]

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
    @task = board.tasks.build(task_params)
    @task.user_id = current_user.id

    if @task.save
      redirect_to board_path(board), notice: 'successfully saved a task!'
    else
      flash.now[:error] = 'failed to save'
      render :new
    end
  end

  def edit
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end

  def update
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to board_task_path(board, @task), notice: 'successfully updated a task!'
    else
      flash.now[:error] = 'failed to update'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @task.destroy!
    redirect_to board_path(board), notice: 'successfully deleted a task!'
  end

  private
  def authenticate_user_task
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    if current_user.id != task.user_id
      redirect_to board_task_path(board, task), notice: 'You don\'t have right'
    end
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :expiration,
      :eyecatch
    )
  end

end

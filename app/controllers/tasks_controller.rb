class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  # GET /tasks
  def index
    @incomplete_tasks = Task.where(completed: false).order(created_at: :asc)
    @completed_tasks  = Task.where(completed: true).order(created_at: :asc)
    @task = Task.new
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
      redirect_back(fallback_location: task_path, notice: "Task was successfully updated.")
      else
      redirect_back(fallback_location: task_path, alert: "Update failed")
      end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end
end

class TodoItemsController < ApplicationController
  before_action :require_user
  before_action :find_todo_list


  def index
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path(@todo_list)
    else
      flash[:error] = "There was a problem adding the todo item."
      render :new
    end
  end

  def edit
    @todo_item = TodoItem.find(params[:id])
  end

  def update
    @todo_item = TodoItem.find(params[:id])
    if @todo_item.update(todo_item_params)
      flash[:success] = "Todo item updated successfully."
      redirect_to todo_list_todo_items_path(@todo_list)
    else
      flash[:error] = "There was a problem updating the todo item."
      render :edit
    end
  end

  def destroy
    @todo_item = TodoItem.find(params[:id])
    @todo_item.destroy
    flash[:success] = "Todo item was successfully destroyed."
    redirect_to todo_list_todo_items_path(@todo_list)
  end

  def complete
    @todo_item = TodoItem.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    flash[:notice] = "Item marked as complete"
    redirect_to todo_list_todo_items_path(@todo_list)
  end

  private
  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end

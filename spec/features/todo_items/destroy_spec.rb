require 'spec_helper'

describe "editing todo items" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of Groceries") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

  it "is successfully deletes todo item" do
    initial_count = TodoItem.count
    visit_todo_list(todo_list)
    within "#todo_item_#{todo_item.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_item.content)
    expect(page).to have_content("Todo item was successfully destroyed")
    expect(TodoItem.count).to eq(initial_count - 1)
  end

end

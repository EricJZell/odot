require 'spec_helper'

describe "deleting todo lists" do
  let!(:user) { create(:user) }
  let!(:todo_list) { user.todo_lists.create(title: "Groceries", description: "Grocery List") }


  before do
    sign_in(user, password: "treehouse1")
  end


  it "Deletes a todo list successfully when clicking destroy link" do
    initial_count = TodoList.count
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(page).to have_content("Todo list was successfully destroyed")
    expect(TodoList.count).to eq(initial_count - 1)
  end

end

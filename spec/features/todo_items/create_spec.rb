require 'spec_helper'

describe "adding todo items" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of Groceries") }

  def add_item(content)
    click_link("New Todo Item")
    fill_in "Content", with: content
    click_button "Save"
  end

  it "is successful with valid content" do
    visit_todo_list(todo_list)
    add_item("Milk")
    expect(page).to have_content("Added todo list item.")
    within("ul.todo_items") do
      expect(page).to have_content("Milk")
    end
  end

  it "displays an error if no content is entered" do
    visit_todo_list(todo_list)
    add_item("")
    click_button "Save"
    within("div.flash") do
      expect(page).to have_content("There was a problem adding the todo item.")
    end
    expect(page).to have_content("Content can't be blank")
  end

  it "displays an error if content is less than 2 characters" do
    visit_todo_list(todo_list)
    add_item("O")
    within("div.flash") do
      expect(page).to have_content("There was a problem adding the todo item.")
    end
    expect(page).to have_content("Content is too short")
  end

end

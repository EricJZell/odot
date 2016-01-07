require 'spec_helper'

describe "editing todo items" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of Groceries") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

  before do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
    within "#todo_item_#{todo_item.id}" do
      click_link "Edit"
    end
  end

  it "is successful with valid content" do
    fill_in "Content", with: "Milk Steak"
    click_button "Save"
    expect(page).to have_content("Todo item updated successfully.")
    within("ul.todo_items") do
      expect(page).to have_content("Milk Steak")
    end
    todo_item.reload
    expect(todo_item.content).to eq("Milk Steak")
  end

  it "is gives an error with no content" do
    fill_in "Content", with: ""
    click_button "Save"
    expect(page).to have_content("Content can't be blank")
    within("div.flash") do
      expect(page).to have_content("There was a problem updating the todo item.")
    end
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end

  it "is gives an error if content is too short" do
    fill_in "Content", with: "I"
    click_button "Save"
    expect(page).to have_content("Content is too short")
    within("div.flash") do
      expect(page).to have_content("There was a problem updating the todo item.")
    end
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end


end

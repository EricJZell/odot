require 'spec_helper'

describe "viewing todo items" do
  let!(:user) { create(:user) }
  let!(:todo_list) { user.todo_lists.create(title: "Groceries", description: "List of Groceries") }

  context "not logged in" do
    it "requires log in" do
      visit "/todo_lists/#{todo_list.id}/todo_items"
      expect(page).to have_content("You must be logged in")
    end
  end

  context "user is signed in" do
    before do
      sign_in(user, password: "treehouse1")
    end

    it "displays the title of the todo list" do
      visit_todo_list(todo_list)
      within("h1.title") do
        expect(page).to have_content(todo_list.title)
      end
    end

    it "displays no items when todo list is empty" do
      visit_todo_list(todo_list)
      expect(page.all("table.todo_items li").size).to eq(0)
    end

    it "displays item content when a todo list has items" do
      todo_list.todo_items.create(content: "Milk")
      todo_list.todo_items.create(content: "Eggs")
      visit_todo_list(todo_list)
      expect(page.all("tbody.todo_items tr").size).to eq(2)
      within("table.todo_items") do
        expect(page).to have_content("Milk")
        expect(page).to have_content("Eggs")
      end
    end
  end

end

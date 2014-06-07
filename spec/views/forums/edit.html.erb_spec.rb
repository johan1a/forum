require 'rails_helper'

RSpec.describe "forums/edit", :type => :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit forum form" do
    render

    assert_select "form[action=?][method=?]", forum_path(@forum), "post" do

      assert_select "input#forum_name[name=?]", "forum[name]"

      assert_select "textarea#forum_description[name=?]", "forum[description]"
    end
  end
end

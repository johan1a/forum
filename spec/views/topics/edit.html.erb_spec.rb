require 'rails_helper'

RSpec.describe "topics/edit", :type => :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      :name => "MyString",
      :last_poster_id => 1
    ))
  end

  it "renders the edit topic form" do
    render

    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do

      assert_select "input#topic_name[name=?]", "topic[name]"

      assert_select "input#topic_last_poster_id[name=?]", "topic[last_poster_id]"
    end
  end
end

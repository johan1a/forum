require 'rails_helper'

RSpec.describe "topics/new", :type => :view do
  before(:each) do
    assign(:topic, Topic.new(
      :name => "MyString",
      :last_poster_id => 1
    ))
  end

  it "renders new topic form" do
    render

    assert_select "form[action=?][method=?]", topics_path, "post" do

      assert_select "input#topic_name[name=?]", "topic[name]"

      assert_select "input#topic_last_poster_id[name=?]", "topic[last_poster_id]"
    end
  end
end

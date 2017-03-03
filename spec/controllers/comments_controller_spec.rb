require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let(:article) { FactoryGirl.create(:article) }
    let(:create_comment) { post :create, params:{ comment: FactoryGirl.attributes_for(:comment), article_id: article.id } }

    it "if instance of CommentClass" do
      create_comment
      expect(assigns(:comment)).to be_a(Comment)
    end

    it "create a new Comment" do
      expect { create_comment }.to change(Comment, :count).by(1)
    end

    it "redirect to article" do
      create_comment
      expect(response).to redirect_to(article_path(article.id))
    end
  end
end
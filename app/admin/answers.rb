ActiveAdmin.register Answer do

  permit_params :ans_content, :question_id, :photo,votes_attributes: [:id]
 
  filter :question_id, :as => :select, collection: Question.all.pluck(:question_title,:id)
  filter :ans_content, :as => :select, collection: Answer.all.pluck(:ans_content,:id)
  filter :votes, :as => :select, collection: Vote.all.pluck(:vote_type,:id)
  filter :created_at
  filter :updated_at

end

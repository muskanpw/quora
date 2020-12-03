ActiveAdmin.register Question do
  permit_params :question_title, :question_date, :user_id,topics_attributes: [:id],answers_attributes: [:id,:ans_content]
  
  form do |f|
    f.inputs do
      f.input :user
      f.input :question_title
      f.input :question_date, as: :datepicker
      end
      f.inputs "Answers" do
        f.has_many :answers, heading: false  do |ans|
        ans.input :ans_content
      end
    end
    f.actions
    end

  filter :question_title, :as => :select, collection: Question.all.pluck(:question_title,:id)
  filter :user_id, :as => :select, collection: User.all.pluck(:name,:id)
  filter :topics, :as => :select, collection: Topic.all.pluck(:topic_name,:id)
  filter :answers, :as => :select, collection: Answer.all.pluck(:ans_content,:id)
  filter :created_at
  filter :updated_at
end

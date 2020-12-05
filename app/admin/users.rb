ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,
  topics_attributes: [:id]
  
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :status
    column :created_at
    actions
  end
  
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :cont_no
      f.input :email
      f.input :password
      f.input :password_confirmation
      #f.input :image

    end
    #f.inputs "Topics" do
     # f.has_many :topics, heading: false  do |tf|
        #####f.input :topics, as: :select, collection: Topic.all.map{|x| [x.topic_name, x.id]}, multiple: true
        ######f.input :topics, :as => :check_boxes, collection: Topic.all.map{|x| [x.topic_name, x.id]}
       # tf.input :id, :as => :select, collection: Topic.all.pluck(:topic_name,:id)
      #end
    #end
    
    f.actions
  end
  scope :all
  scope :pending, group: :status
  scope :approved, group: :status
  scope :rejected, group: :status

  action_item :reject, only: :show, if: proc { resource.status == 'approved' } do 
    link_to "Reject",  reject_user_admin_user_path(resource.id), method: :post
  end
   
  action_item :approve, only: :show, if: proc { resource.status == 'rejected' } do
    link_to "Approve", approve_user_admin_user_path(resource.id), method: :post
  end
  
  action_item :approve, only: :show, if: proc { resource.status ==  'pending'} do
    link_to "Approve", approve_user_admin_user_path(resource.id), method: :post
  end
  

  member_action :approve_user, method: :post do
    resource.update_column(:status, 'approved')
    redirect_to resource_path, notice: "User approved successfully"
  end

  member_action :reject_user, method: :post do
    resource.update_column(:status, 'rejected')
    redirect_to resource_path, notice: "User rejected successfully"
  end
  

  controller do
    def scoped_collection
      
      User.all
    end

    # def create
    #   # super do
    #   #   if resource.valid?
    #   #     resource.topics.destroy_all
    #   #     byebug
    #   #     # params[:topics][:ids].each do |topic_id|
    #   #     #   topic = Topic.find(topic_id)
    #   #     #   resource.topics << topic
    #   #     # end
    #   #   end
    #   # end
    # end
=begin
    def update
      super do
        byebug
        if resource.valid?
          #resource.topics.destroy_all
          
          params[:topics][:ids].each do |topic_id|
            user = User.find(user_id)
            resource.users << user
          end
       end
      end
    end
=end   
  end
end

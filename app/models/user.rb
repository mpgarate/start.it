class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }


  has_many :ideas, inverse_of: :user
  has_many :questions, inverse_of: :user
  has_many :aspects, inverse_of: :user
  has_many :answers, inverse_of: :user
  has_many :solutions, inverse_of: :user
  has_many :comments, inverse_of: :user
  has_one :profile, dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  
  after_create :create_user_profile

  def name
    first_name.to_s + " " + last_name.to_s
  end


  def clear_points_if_negative
    if self.points < 0
      self.add_points(self.points.abs)
    end
  end

  def create_user_profile
    Profile.create(:user_id => self.id)
  end

  def up_voted_for?(item)
    eval = LabEvaluation.where(evaluator: self, content_type: item.class, content: item).first
    eval.present? && eval.value > 0 ? true : false
  end

  def down_voted_for?(item)
    eval = LabEvaluation.where(evaluator: self, content_type: item.class, content: item).first
    eval.present? && eval.value < 0 ? true : false
  end

  #alias merit gem spelling quirk
  alias_method :subtract_points, :substract_points
  
end

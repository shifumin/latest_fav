class UserForm
  include ActiveModel::Model

  attr_accessor :screen_name

  validates :screen_name, presence: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/ }

  def save
    return false if invalid?
    true
  end
end

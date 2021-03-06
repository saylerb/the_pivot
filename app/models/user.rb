class User < ActiveRecord::Base
  has_many :bids
  has_many :items, through: :bids
  has_many :business_admins
  has_many :businesses, through: :business_admins

  validates :username, presence: :true, uniqueness: :true
  validates :password, presence: :true
  validates :email, presence: :true
  validates :name, presence: :true
  validates :address, presence: :true
  validates :city, presence: :true
  validates :state, presence: :true
  validates :zip, presence: :true

  has_secure_password validations: false
  validates_confirmation_of :password, message: "does not match"
  validates_confirmation_of :email, message: "does not match"


  def to_param
  end

  def open_items
    self.items.open.distinct
  end

  def platform_admin?
    self.platform_admin
  end

  def business_admin?
    self.businesses.exists?
  end

  def admin?
    self.businesses.exists? || self.platform_admin?
  end

  def won_items
    self.items.find_all { |item| self == item.high_bidder && item.closed? }.uniq
  end

  def closed_items
    self.items.closed.distinct
  end

  def lost_items
    self.items.find_all { |item| self != item.high_bidder && item.closed? }.uniq
  end
end

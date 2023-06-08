class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :likes
    has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
  
    validates :name, presence: true
    validates :password, presence: true
end

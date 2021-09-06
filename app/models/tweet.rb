class Tweet < ApplicationRecord
  has_many_attached :images
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :challenge, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # 通知機能
  has_many :notifications, dependent: :destroy
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


  enum hour_attribute: {
    "---": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5,
    "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "11": 12, "13": 14, "15": 15,
    "16": 16, "17": 17, "18": 18, "19": 19, "20": 20,
    "21": 21, "22": 22, "23": 23, "24": 24,
  }, _suffix: true

  enum minute_attribute: {
    "00": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5,
    "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "11": 12, "13": 14, "15": 15,
    "16": 16, "17": 17, "18": 18, "19": 19, "20": 20,
    "21": 21, "22": 22, "23": 23, "24": 24, "25": 25,
    "26": 26, "27": 27, "28": 28, "29": 29, "30": 30,
    "31": 31, "32": 32, "33": 33, "34": 34, "35": 35,
    "36": 36, "37": 37, "38": 38, "39": 39, "40": 40,
    "41": 41, "42": 42, "43": 43, "44": 44, "45": 45,
    "46": 46, "47": 47, "48": 48, "49": 49, "50": 50,
    "51": 51, "52": 52, "53": 53, "54": 54, "55": 55,
    "56": 56, "57": 57, "58": 58, "59": 59,
  }, _suffix: true
end

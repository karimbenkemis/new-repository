class User < ApplicationRecord
  enum status: { deleted: 0, active: 1, archived: 2}

  scope :inactivated, -> { where status: 0 }
  scope :activated,   -> { where status: 1 }
  scope :archived,    -> { where status: 2 }

  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true

  def destroy
    update(status: 0)
  end

  def archive
    update(status: 2)
  end

  def unarchive
    update(status: 1)
  end
end

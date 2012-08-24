# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name
  # Hook para antes de guardar, convertir a minusculas
  before_save { |user| user.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Se valida unicidad, pero de cualquier forma es importante crear el unique a nivel base de datos
  # ver http://ruby.railstutorial.org/chapters/modeling-users?version=3.2#sec-the_caveat
  # El indice se crea en db/migrate/x_add_index_to_users_email
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX  }        ,
                    uniqueness: { case_sensitive: false }



end
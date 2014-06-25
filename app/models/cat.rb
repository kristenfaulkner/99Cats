class Cat < ActiveRecord::Base
  validates :name, :age, :birth_date, :color, :sex, presence: true
  validates_numericality_of :age, on: :create
  validates_inclusion_of :color, in: ["black", "white", "gray", "red", "polka_dot"]
  validates_inclusion_of :sex, in: ["M", "F"]
end
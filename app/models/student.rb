class Student < ActiveRecord::Base
  # Remember to create a migration!

  validates :first_name, :last_name, :birthday, :phone, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 5 }
  validates :phone, format: { with: /\A(\d{10,}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4,})\z/ }

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name=(new_name)
    names = new_name.split(' ')
    if names.length == 2
      self.first_name = names[0]
      self.last_name = names[1]
      true
    elsif names.length == 3
      self.first_name = "#{names[0]} #{names[1]}"
      self.last_name = names[2]
    end
  end

  def age
    return false if birthday == nil
    if Date.today.month - birthday.month >= 0
      if Date.today.day - birthday.day >= 0
        Date.today.year - birthday.year
      else Date.today.year - birthday.year - 1
      end
    elsif Date.today.month - birthday.month < 0
      Date.today.year - birthday.year - 1
    end
  end
end

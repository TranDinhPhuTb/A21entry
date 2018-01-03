class Game < ApplicationRecord
  belongs_to :match
  belongs_to :winner, class_name: "Team"
end

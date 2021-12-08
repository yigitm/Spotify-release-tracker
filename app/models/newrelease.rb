class Newrelease < ApplicationRecord
  scope :data_destroy, -> { Newrelease.delete_all }
end

class Shipping < ApplicationRecord
  belongs_to :purchase, optional: true
end

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :article
end

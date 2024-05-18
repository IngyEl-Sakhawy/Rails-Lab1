class Article < ApplicationRecord
    include Visible
    
    belongs_to :user
    has_one_attached :image
    has_many :reports, dependent: :destroy, counter_cache: true
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :body, presence: true
    
    def public?
        self.status == "public"
    end
    private

    
end

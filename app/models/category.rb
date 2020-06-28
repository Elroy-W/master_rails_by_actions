class Category < ApplicationRecord

    validates :title, presence: {message: "Title can not be blank"}
    validates :title, uniqueness: {message: "Title can not be repeated"}

    has_ancestry orphan_strategy: :destroy
    
    has_many :products, dependent: :destroy

    before_validation :correct_ancestry
  
    def self.grouped_data
      self.roots.order("weight desc").inject([]) do |result, parent|
        row = []
        row << parent
        row << parent.children.order("weight desc")
        result << row
      end
    end

    private
    def correct_ancestry
      self.ancestry = nil if self.ancestry.blank?
    end
end

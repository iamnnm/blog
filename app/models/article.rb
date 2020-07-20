# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, :text, presence: true
  validates :title, length: { maximum: 100 }
  validates :text, length: { maximum: 10_000 }
end

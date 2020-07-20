# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { generate(:string) }
    text { generate(:string) }
  end
end

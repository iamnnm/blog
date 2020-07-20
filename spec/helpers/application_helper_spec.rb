# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'bootstrap_class_for' do
    it 'should return class of css' do
      expect(bootstrap_class_for(:success)).to eq('alert-massage-success')
    end
  end
end

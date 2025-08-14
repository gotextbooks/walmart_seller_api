# frozen_string_literal: true

require "spec_helper"

RSpec.describe WalmartSellerApi::ApiError do
  describe '.extract_error_message' do
    it do
      response = {
        'errors' => {
          'error' => {
            'message' => 'message',
            'description' => 'description',
            'info' => 'info'
          }
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => {
            'description' => 'message',
            'info' => 'info'
          }
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => {
            'info' => 'message'
          }
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => [{
            'message' => 'message',
            'description' => 'description',
            'info' => 'info'
          }]
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => [{
            'description' => 'message',
            'info' => 'info'
          }]
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => [{
            'info' => 'message'
          }]
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'errors' => {
          'error' => [{
            'info' => 'message'
          }, {
            'info' => 'another message'
          }]
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message and another message')
    end

    it do
      response = {
        'error' => {
          'message' => 'message',
          'description' => 'description',
          'info' => 'info'
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => {
          'description' => 'message',
          'info' => 'info'
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => {
          'info' => 'message'
        }
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => [{
          'message' => 'message',
          'description' => 'description',
          'info' => 'info'
        }]
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => [{
          'description' => 'message',
          'info' => 'info'
        }]
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => [{
          'info' => 'message'
        }]
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'error' => 'message'
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'message' => 'message',
        'description' => 'description',
        'info' => 'info'
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'description' => 'message',
        'info' => 'info'
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      response = {
        'info' => 'message'
      }.to_json

      message = described_class.extract_error_message(response)

      expect(message).to eq('message')
    end

    it do
      message = described_class.extract_error_message('message')

      expect(message).to eq('message')
    end
  end
end

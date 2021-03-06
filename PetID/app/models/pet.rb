# frozen_string_literal: true

class Pet < ApplicationRecord
  #validations
  validates :name, presence: true
  validates :animal_type, presence: true
  validates :animal_type, inclusion: { in: %w[Dog Cat Bunny], message: '%{value} is not a valid animal type' } 
  validates :breed, presence: true
  validates :breed, inclusion: { in: #self.allowed_breeds not accepted so copy and pasted array, but was able to uses method for forms
    ['Boston Terrier', 'French Bulldog', 'Golden Retriever', 'Black Lab', 'Poodle', 'German Shepherd', 'Beagle', '
  Chihuahua', 'Greyhound', 'English Bulldog', 'Pug', 'Siberian Husky', 'Boxer', 'Pointer', 'Yorkshire Terrier',
  'Mutt', 'Russian Blue', 'Persian', 'British Shorthair', 'Scottish Fold', 'Siamese', 'Ragdoll', 'Maine Coon',
  'Munchkin', 'Sphynx', 'Abyssinian', 'Holland Lop', 'Rex Rabbit', 'Netherland Dwarf Rabbit',
  'Flemish Giant Rabbit', 'Mini Lop'], message: '%{value} is not a valid animal breed' }
  validates :gender, presence: true
  validates :gender, inclusion: { in: %w[Male Female], message: '%{value} is not a valid gender' }
  validates :birthdate, presence: true
  validate :validate_age
  validates :weight, presence: true
  validates :weight, numericality: { greater_than: 0 }
  validates :image, presence: true

  #associations
  belongs_to :user
  has_many :appointments, through: :user

  def self.allowed_types
    %w[Dog Cat Bunny]
  end

  def self.allowed_breeds
    ['Boston Terrier', 'French Bulldog', 'Golden Retriever', 'Black Lab', 'Poodle', 'German Shepherd', 'Beagle', '
    Chihuahua', 'Greyhound', 'English Bulldog', 'Pug', 'Siberian Husky', 'Boxer', 'Pointer', 'Yorkshire Terrier',
     'Mutt', 'Russian Blue', 'Persian', 'British Shorthair', 'Scottish Fold', 'Siamese', 'Ragdoll', 'Maine Coon',
     'Munchkin', 'Sphynx', 'Abyssinian', 'Holland Lop', 'Rex Rabbit', 'Netherland Dwarf Rabbit',
     'Flemish Giant Rabbit', 'Mini Lop']
  end

  def self.allowed_genders
    %w[Male Female]
  end

  scope :order_by, ->(attr) { order("#{attr} DESC") }

  private

  def validate_age
    if birthdate > 1.day.ago
      errors.add(:birthdate, 'Your Pet Should Be Over 1 Day Old.')
    end
  end
end

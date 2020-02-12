class Image < ApplicationRecord
  validates :link, presence: true
  validate :check_link
  acts_as_taggable

  private

  def check_link
    if link !~ %r{^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$}ix
      errors.add(:base, :link_invalid, message: 'Link is invalid')
      return
    end

    errors.add(:base, :link_invalid, message: 'Link is not an image address') unless image?
  end

  def image?
    is_image = false
    %w[.jpeg .img .jpg .gif].any? do |ending|
      is_image = true if link.to_s.end_with?(ending)
    end

    is_image
  end
end

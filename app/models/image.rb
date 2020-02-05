class Image < ApplicationRecord
  validates :link, presence: true
  validates :tag, presence: true
  validate :check_link

  private

  def check_link
    if link !~ %r{^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$}ix
      errors.add(:base, :link_invalid, message: 'Link is invalid')
      return
    end

    errors.add(:base, :link_invalid, message: 'Link is not an image address') unless image?
  end

  def image?
    url = URI.parse(link)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    http.head(url.request_uri)['Content-Type'].start_with? 'image'
  end
end

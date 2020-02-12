module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :url, locator: '#link'
        element :tag_list, locator: '#tag_list'
      end

      def create_image!(url: nil, tags: nil)
        image.url.set(url) if url.present?
        image.tag_list.set(tags) if tags.present?
        node.click_button('Save')
        stale!
        window.change_to(ShowPage, NewPage)
      end

      def error_message
        node.find('.error-message').text
      end
    end
  end
end

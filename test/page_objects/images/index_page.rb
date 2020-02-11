module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '#image-list', item_locator: '.image-container', contains: ImageCard do
        def view!
          node.click_on('Show')
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        Image.all.any? do |image|
          tag_list = []
          image.tags.each do |tag|
            tag_list.append(tag.name)
          end

          image.link == url && (!tags.present? || tags == tag_list.join(', '))
        end
      end

      def click_tag!(tag_name)
        node.find("a[href*='tag=#{tag_name}']:first-child").click
        stale!
        window.change_to(IndexPage)
      end

      def clear_tag_filter!
        node.click_on('Clear Filter')
        stale!
        window.change_to(IndexPage)
      end
    end
  end
end

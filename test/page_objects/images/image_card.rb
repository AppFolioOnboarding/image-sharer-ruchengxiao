module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def click_tag!(tag_name)
        node.click_on(tag_name)
        stale!
        window.change_to(IndexPage)
      end
    end
  end
end

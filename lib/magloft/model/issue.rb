module Magloft
  module Model
    class Issue < Base
      collection_path "api/portal/v1/issues/:app_id"
      def process_links
        url = self.class.build_request_path("#{self.class.collection_path}/:id/process_links", id: id)
        self.class.put_raw(url)
        true
      end

      def typeloft_pages
        TypeloftPage.where(issue_id: id)
      end

      def build_page(design_identifier, options = {})
        TypeloftPage.build({
          position: 0,
          design_identifier: design_identifier,
          template_identifier: "blank",
          issue_id: id
        }.merge(options))
      end
    end
  end
end

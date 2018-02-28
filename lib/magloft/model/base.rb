module Magloft
  module Model
    class Base
      include Her::Model
      use_api Magloft::API

      def self.build_request_path(path = nil, parameters = {})
        parameters = parameters.try(:with_indifferent_access)

        unless path.kind_of?(String)
          parameters = path.try(:with_indifferent_access) || parameters
          path =
            if parameters.include?(primary_key) && parameters[primary_key] && !parameters[primary_key].kind_of?(Array)
              resource_path.dup
            else
              collection_path.dup
            end

          # Replace :id with our actual primary key
          path.gsub!(%r{(\A|/):id(\Z|/)}, "\\1:#{primary_key}\\2")
        end

        path.gsub(/:([\w_]+)/) do
          # Look for :key or :_key, otherwise raise an exception
          key = $1.to_sym
          value = parameters.delete(key) || parameters.delete(:"_#{key}")
          if value
            Faraday::Utils.escape value
          elsif $1 == "app_id"
            Magloft.app_id
          else
            raise(Her::Errors::PathError.new("Missing :_#{$1} parameter to build the request path. Path is `#{path}`. Parameters are `#{parameters.symbolize_keys.inspect}`.", $1))
          end
        end
      end
    end
  end
end

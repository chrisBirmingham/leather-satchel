# frozen_string_literal: true

module Leather
  module Satchel
    class LeatherSatchel
      attr_writer :config_files, :config_directories

      def initialize
        @config_files = ['config.yml']
        @config_directories = ['.']
      end

      # @return [Container]
      def process
        container = Container.new
        loader = Loader::YAMLLoader.new
        parser = ConfigParser.new(loader)
        parameter_resolver = ParameterResolver.new
        container_builder = ContainerBuilder.new(parameter_resolver)

        @config_directories.each do |directory|
          @config_files.each do |file|
            file_path = "#{directory}/#{file}"
            next unless File.exist?(file_path)

            config = parser.parse_file(file_path)
            container_builder.build(config, container)
          end
        end

        container
      end
    end
  end
end

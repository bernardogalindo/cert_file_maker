module CertFileMaker
  class Generator
    def initialize(config)
      begin
        @config = config.fetch(:cert_names)
      rescue KeyError => e

      end
    end
  end
end

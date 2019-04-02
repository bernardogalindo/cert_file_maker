module CertFileMaker
  class Railtie < Rails::Railtie
    config.before_configuration do
      CertFileMaker.validate
    end

    initializer 'cert_file_maker.generate', before: 'active_record.initialize_database' do
      CertFileMaker.generate
    end
  end
end

require 'yaml'
module CertFileMaker
  @@cert_names = []
  def self.validate
    begin
      configuration = {}
      file = 'config/cert_file_maker.yml'
      raise StandardError unless File.exists?(file)
      yfile = ::YAML.load_file(file)
      configuration = yfile if yfile
      names = configuration.fetch('cert_names')
      @@cert_names = names.split(',') if names
    rescue KeyError => e
      puts "=> CertFileMaker: config/cert_file_maker.yml #{e}"
      raise KeyError
    rescue StandardError => e
      puts "=> CertFileMaker: #{e} => Please create config/cert_file_maker.yml file with cert_names key"
      raise StandardError
    end
  end

  def self.cert_names
    @@cert_names
  end

  def self.generate
    begin
      puts '=> CertFileMaker starting'
      cert_names.each do |cert|
        next if File.exists?("#{cert.downcase}.pem")
        cert_file = ENV.fetch(cert)
        File.open("#{cert.downcase}.pem", 'w+') do |f|
          f.write cert_file
        end
        puts "=> CertFileMaker => Created: #{cert.downcase}.pem"
      end
      puts '=== CertFileMaker configured ==='
    rescue KeyError => e
      puts "=> CertFileMaker Requires Environment variable exists => #{e}"
      raise KeyError
    end
  end
end

require 'cert_file_maker/railtie' if defined?(Rails)

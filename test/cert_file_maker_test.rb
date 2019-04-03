require 'test_helper'

class TestCertFileMaker < Minitest::Test
  def setup
    @init = Dir.pwd
    @test_obj = CertFileMaker
    Dir.chdir('test')
  end

  def teardown
    Dir.chdir(@init)
  end

  def test_that_config_file_is_required
    assert_raises(StandardError){ @test_obj.validate }
  end

  def test_that_require_cert_names
    file = File.open('config/cert_file_maker.yml', 'w+') do |f|
      f.write "cert_name: 'test1,test2'"
    end
    assert_raises(KeyError) do
      @test_obj.validate
    end
    File.delete('config/cert_file_maker.yml')
  end

  def test_that_generate_requires_env_vars
    file = File.open('config/cert_file_maker.yml', 'w+') do |f|
      f.write "cert_names: 'test1,test2'"
    end
    @test_obj.validate
    assert_raises(KeyError) do
      @test_obj.generate
    end
    File.delete('config/cert_file_maker.yml')
  end

  def test_that_generate_pem_files
    file = File.open('config/cert_file_maker.yml', 'w+') do |f|
      f.write "cert_names: 'test1,test2'"
    end
    @test_obj.validate
    ENV.stub :fetch, 'random cert' do
      @test_obj.generate
      assert File.exists?('test1.pem')
      assert File.exists?('test2.pem')
    end
    File.delete('test1.pem')
    File.delete('test2.pem')
    File.delete('config/cert_file_maker.yml')
  end
end


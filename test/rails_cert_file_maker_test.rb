# encoding: utf-8
require 'test_helper'

class TestRailsCertFileMaker < Minitest::Test
  def assert_output(expected, io, timeout = 10)
    timeout = Time.now + timeout

    output = +""
    until output.include?(expected) || Time.now > timeout
      if IO.select([io], [], [], 0.1)
        output << io.read(1).force_encoding('utf-8')
      end
    end

    assert_includes output, expected, "#{expected.inspect} expected, but got:\n\n#{output}"
  end

  def setup
    @init_dir = Dir.pwd
    @rails_app_dir = 'test/rails_app/'
  end

  def teardown
    Dir.chdir(@init_dir)
  end

  def test_cert_file_maker_output_when_rails_server
    ENV['CERT_TEST'] = 'Test cert'
    ENV['PRIVATE_KEY'] = 'Private key'
    @pid = nil
    Dir.chdir(@rails_app_dir) do
      begin
        primary, replica = PTY.open
        @pid = Process.spawn("bin/rails server", chdir: Dir.pwd, in: replica, out: replica, err: replica)
        #puts "Rails booting on pid => #{@pid}"
output = <<-OUTPUT
=> CertFileMaker loading\r
=> CertFileMaker => Created: cert_test.pem\r
=> CertFileMaker => Created: private_key.pem\r
=== CertFileMaker loaded ===\r
OUTPUT
        assert_output(output.force_encoding('utf-8'), primary)
        assert File.exists?('cert_test.pem')
        assert File.exists?('private_key.pem')
      ensure
        puts 'ensuring'
        File.delete('cert_test.pem')
        File.delete('private_key.pem')
        Process.kill("TERM", @pid)
        Process.kill("TERM", @pid)
        #Process.wait(@pid)
      end
    end
  end

  def test_cert_file_maker_output_when_rails_server_using_encrypted_cred
    @pid = nil
    Dir.chdir(@rails_app_dir) do
      begin
        primary, replica = PTY.open
        @pid = Process.spawn("RAILS_ENV='development' bin/rails server", chdir: Dir.pwd, in: replica, out: replica, err: replica)
        #puts "Rails booting on pid => #{@pid}"
output = <<-OUTPUT
=> CertFileMaker loading\r
=> CertFileMaker => Created: cert_test.pem\r
=> CertFileMaker => Created: private_key.pem\r
=== CertFileMaker loaded ===\r
OUTPUT
        assert_output(output.force_encoding('utf-8'), primary)
        assert File.exists?('cert_test.pem')
        assert File.exists?('private_key.pem')
      ensure
        puts 'ensuring'
        File.delete('cert_test.pem')
        File.delete('private_key.pem')
        Process.kill("TERM", @pid)
        Process.kill("TERM", @pid)
        #Process.wait(@pid)
      end
    end
  end
end

# Cert File Maker

[Cert File Maker] is a tool to generate pem files (certificates, public keys)
files from environment variables.

## Install
Add `cert_file_maker` to your Gemfile

```ruby
  gem 'cert_file_maker'
```

Add `cert_file_maker.yml` config file to your `config` folder. Config folder
should live inside application root.


```ruby
  # config/cert_file_maker.yml
  cert_names: 'PRIVATE_KEY,CERT'
```
#### Important cert_names
This variable should contain the exac name of your credential,
environment_variables.

The certification file should contain the `cert_names` key with a string of
names separeted by a comma.


### Ruby on Rails

Using ruby rails should be as easy as installed the gem. Because, this contains
a railtie class that appended before active_record establish connection.

### Pure Ruby App

You should require the 'cert_file_maker' and validate and generate files

```ruby
  require 'cert_file_maker'
  # validate
  CertFileMaker.validate
  # generate
  CertFileMaker.generate
```

require_relative 'lib/jetspider/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'jetspider'
  s.version = JetSpider::VERSION
  s.summary = 'basic JavaScript compiler'
  s.description = 'Basic small JavaScript compiler to SpiderMonkey'
  s.license = 'MIT'

  s.author = ['Minero Aoki']
  s.email = 'minero-aoki@cookpad.com'
  s.homepage = 'https://ghe.ckpd.co/minero-aoki/jetspider'

  s.executables = Dir.entries('bin').select {|ent| File.file?("bin/#{ent}") }
  s.files = Dir.glob(%w[README.md bin/* lib/**/*.rb])
  s.require_path = 'lib'

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'rkelly-remix', '0.0.7'
  s.add_development_dependency 'pry'
end

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "lib" << "test" << "spec"
  t.pattern = 'test/**/*_{test,spec}.rb'
  t.verbose = true
end

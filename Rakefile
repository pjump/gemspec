task :gem => 'templates/init/Gemfile'

file 'templates/init/Gemfile' => 'templates.erb/init/Gemfile.erb' do |t|
  sh "erb #{Shellwords.escape t.source} > #{Shellwords.escape t.name}"
end

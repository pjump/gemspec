require 'rubygems/package_task'
$:.unshift(File.expand_path('../lib',__FILE__))

$gemspec = Gem::Specification.load(Dir["*.gemspec"][0])
files = Rake::FileList.new(Gemspec::Git.ls_files)

Gem::PackageTask.new($gemspec) { }
task :gem => :chmod
task :chmod do
  files.each do |file|
    chmod 'o+r', file unless File.world_readable?(file)
  end
end

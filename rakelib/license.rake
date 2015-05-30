directory "LICENSES"
$gemspec = Gem::Specification.load(Dir["*.gemspec"][0])

file "LICENSES/.info" => "gemspec.gemspec" do |t|
  mkdir_p "LICENSES"

  licenses_dir = File.expand_path('../../licenses/', `gem which gemspec`.chomp)
  $? == 0 or licenses_dir = File.expand_path('licenses/')

  $gemspec.licenses.each do |license|
    cp File.join(licenses_dir, license), "LICENSES/#{Shellwords.escape license}"
  end
  File.write(t.name, "This directory contains the licenses you can use with this gem\n")
end

desc "Fill LICENSES/ with licenses according to gemspec.gemspec"
task 'license' => 'LICENSES/.info' do
  sh "cd LICENSES/; less *"
end

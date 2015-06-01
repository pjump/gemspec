
desc 'Render licenses into LICENSES/'
task 'licenses' => 'LICENSES/.info'

desc 'View licenses'
task 'view-licenses' => 'licenses' do
  sh "less", *Dir["LICENSES/*"]
end

#############################################3

directory "LICENSES"
gemspec = Gem::Specification.load(Dir["*.gemspec"][0])

def render_erb(s, src, dest)
     File.write(dest, 
                ERB.new(File.read(src), nil, '-').result(binding)
               )
end

file "LICENSES/.info" => "gemspec.gemspec" do |t|
  mkdir_p "LICENSES"

  licenses_dir = File.expand_path('../../share/gemspec/licenses/', `gem which gemspec`.chomp)
  $? == 0 or licenses_dir = File.expand_path('licenses/')

  gemspec.licenses.each do |license|
    render_erb(gemspec,
               File.join(licenses_dir, license + '.erb'),
               "LICENSES/#{Shellwords.escape license}"
    )
  end
  File.write(t.name, "This directory contains the licenses you can use with this gem\n")
end


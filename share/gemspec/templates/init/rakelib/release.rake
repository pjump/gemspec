require 'gemspec/git'

desc "Push master to origin, build gem, and push it"
task 'release' => 'gem' do
  Gemspec::Git.cdroot!
  Gemspec::Git.clean? or (
    warn "Need to clean up before releasing"
    exit 1
  )
  sh "git checkout master"
  s = Gem::Specification.load('gemspec.gemspec')
  sh <<-EOF
    git push origin master &
    rake gem && gem push pkg/#{s.name}-#{s.version}.gem
    wait
  EOF
end

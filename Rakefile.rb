require 'rubygems' 
require 'bundler/setup'

require 'albacore'
 
task :default => [:msbuild]
 
msbuild :msbuild do |msb|
  msb.properties = { :configuration => :Debug }
  msb.targets = [ :Clean, :Build ]      
  msb.solution = "src/iqt-teamcity-test.sln"
end

task :gittask do
  cmd = 'git add -A'
  system(cmd)
  cmd1 = 'git commit -m "auto commit"'
  system(cmd1)
  cmd2 = 'git push origin master'
  system(cmd2)
end

task :release => [:msbuild, :gittask] do
  puts 'What happens in TeamCity stays in TeamCity.'
end
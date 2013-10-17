require 'rubygems' 
require 'bundler/setup'

require 'albacore'
 
task :default => [:msbuild]
 
msbuild :msbuild do |msb|
  msb.properties = { :configuration => :Debug }
  msb.targets = [ :Clean, :Build ]      
  msb.solution = "src/iqt-teamcity-test.sln"
end
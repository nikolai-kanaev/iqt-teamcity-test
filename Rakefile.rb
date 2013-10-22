require 'rubygems' 
require 'bundler/setup'

$: << './'

require 'version_bumper'
require 'albacore'
require 'erb'
require 'yaml'
# require 'nokogiri' why is this needed? FOR XML SERIALIZATION

require 'buildscripts/morph'
require 'buildscripts/environment'

zip :zip_copy_backup do |zip|
  puts "Zippar foldern och lägger den i C:/Backup/iqt-teamcity-test/"
  backupfolder = "C:/Backup/iqt-teamcity-test/"
  FileUtils.mkdir backupfolder if File.directory?(backupfolder) == false
  zip.directories_to_zip "src/iqt-teamcity-test/bin/debug"
  zip.output_file = "debug.zip"
  zip.output_path = backupfolder
end

zip :do_zip do |zip|
  zip.directories_to_zip "src/iqt-teamcity-test/bin/debug"
  zip.output_file = "debug.zip"
  zip.output_path = "./"
end

morph :app_morph do |m|
  YAML::ENGINE.yamler = "psych"
  settings = YAML.load(File.open(File.join('src', 'Deployment', 'appconfig.yml')))
  m.template = "src/Deployment/app.erb.config"
  m.output = "src/iqt-teamcity-test/App.config"
  m.settings settings[ENV_TARGET]
end
 
Albacore.configure do |config|
  config.mstest.command = "C:/Program\ Files\ (x86)/Microsoft Visual Studio 11.0/Common7/IDE/mstest.exe"
  config.msbuild.targets = [ :Clean, :Build ]
end
 
task :default => [:app_morph, :msbuild, :mstest, :do_zip]
 
desc "Builds the project using the MSBuild project files"
msbuild :msbuild => [:assemblyinfo] do |msb|
  msb.properties = { :configuration => :Debug }
  msb.solution = "src/iqt-teamcity-test.sln"
end
 
desc "Runs the tests in the AlbacoreDemo.Tests project"
mstest :mstest => [:msbuild] do |mstest|
  mstest.assemblies "src/iqt-teamcity-test.Test/bin/Debug/iqt-teamcity-test.Test.dll"
end
 
desc "Updates AssemblyInfo version number"
assemblyinfo :assemblyinfo do |asm|
  asm.version = bumper_version.to_s
  asm.file_version = bumper_version.to_s
  asm.company_name = "Interfleet"
  asm.product_name = "TeamCity Test"
  asm.copyright = "Nikolai Kanaev"
  asm.output_file = "src/iqt-teamcity-test/Properties/AssemblyInfo.cs"
end

task :gittask do
  cmd = 'git add -A'
  system(cmd)
  cmd1 = 'git commit -m "auto commit"'
  system(cmd1)
  cmd2 = 'git push origin master'
  system(cmd2)
end

task :release => [:msbuild, :mstest, :do_zip, :gittask] do
  puts 'What happens in TeamCity stays in TeamCity.'
end
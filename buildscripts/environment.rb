namespace :env do
	task :dev do
		ENV['ENV_TARGET'] = ENV_TARGET = 'dev'
		puts "Environment target: #{ENV_TARGET}"
		
		# ENV['ENV_NETWORKSHAREHOST'] = ENV_NETWORKSHAREHOST = 'Dev'
		# ENV['ENV_NETWORKSHAREUSERNAME'] = ENV_NETWORKSHAREUSERNAME = 'ciber\nikkan'
		# ENV['ENV_NETWORKSHAREPASSWORD'] = ENV_NETWORKSHAREPASSWORD = 'foobar123'
		# ENV['ENV_DEPLOYMENTFOLDER'] = ENV_DEPLOYMENTFOLDER = ''
		# ENV['ENV_BACKUPNETWORKSHARELOCALNAME'] = ENV_BACKUPNETWORKSHARELOCALNAME = 'Z:'
		# ENV['ENV_DEPLOYNETWORKSHARELOCALNAME'] = ENV_DEPLOYNETWORKSHARELOCALNAME = 'Y:'
		# ENV['ENV_TEAMCITYBUILDPATH'] = ENV_TEAMCITYBUILDPATH = File.join(File.dirname("C:/"), "builds/")
	end
	task :test do
		ENV['ENV_TARGET'] = ENV_TARGET = 'test'
		puts "Environment target: #{ENV_TARGET}"
	end
	task :acc do
		ENV['ENV_TARGET'] = ENV_TARGET = 'acc'
		puts "Environment target: #{ENV_TARGET}"
	end
	task :prod do
		ENV['ENV_TARGET'] = ENV_TARGET = 'prod'
		puts "Environment target: #{ENV_TARGET}"
	end
end
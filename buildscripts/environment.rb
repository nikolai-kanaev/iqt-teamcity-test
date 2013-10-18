namespace :env do
	task :dev do
		ENV['ENV_TARGET'] = ENV_TARGET = 'dev'
		puts "Environment target: #{ENV_TARGET}"
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
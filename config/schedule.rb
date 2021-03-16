# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, {:error => '~/Desktop/whenever-err.log', :standard => '~/Desktop/whenever-output.log'} 

every :minute do 
	#create 10 cars every minute
	command "curl --location --request POST 'http://localhost:3000/builder_robot/create_cars/10' "
end

every 3.minutes do 
	#advance 35 cars through the basic queue
	command "curl --location --request POST 'http://localhost:3000/process_queue/basic/35'"
end

every 3.minutes do 
	#advance 35 cars through the electronic queue
	command "curl --location --request POST 'http://localhost:3000/process_queue/electronic/35'"
end

every 3.minutes do 
	#advance 35 cars through the painting queue
	command "curl --location --request POST 'http://localhost:3000/process_queue/painting/35'"
end


every 30.minutes do 
	#request the guard robot, quality control and transportation
	command "curl --location --request POST 'http://localhost:3000/quality_control_and_transportation"
end

every :minute do 
	#create 10 cars every minute
	command 'ruby /Users/joaquinconsoni/workspace/robot-world/robot-world/scripts/purchase-robot.rb > ~/Desktop/robot-world-output.txt' 
end

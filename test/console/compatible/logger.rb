# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'console/compatible/logger'
require 'console/terminal/logger'

describe Console::Compatible::Logger do
	let(:io) {StringIO.new}
	let(:output) {Console::Terminal::Logger.new(io)}
	let(:logger) {Console::Compatible::Logger.new("Test", output)}
	
	it "should log messages" do
		logger.info("Hello World")
		
		expect(io.string).to be(:include?, "Hello World")
	end
	
	it "formats lower case severity string" do
		expect(logger.format_severity(1)).to be == :info
	end
	
	it "can write a message" do
		logger << "Hello World"
		
		expect(io.string).to be(:include?, "Hello World")
	end
	
	it "can override progname" do
		logger.add(Logger::INFO, "Hello World")
		
		expect(io.string).to be(:include?, "Hello World")
	end
	
	it "can generate message from block" do
		logger.info{"Hello World"}
		
		expect(io.string).to be(:include?, "Hello World")
	end
	
	it "has a default log level" do
		expect(logger.level).to be_a(Integer)
		expect(logger.level).to be == ::Logger::DEBUG
	end
end

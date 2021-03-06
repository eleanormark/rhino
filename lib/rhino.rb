require "rack"
require "slop"
require "socket"
require "time"
require "uri"

require "rhino/cli"
require "rhino/config"
require "rhino/http"
require "rhino/launcher"
require "rhino/logger"
require "rhino/server"
require "rhino/version"

module Rhino
  def self.config
    @config ||= Rhino::Config.new
  end

  def self.logger
    @logger ||= Rhino::Logger.new
  end
end

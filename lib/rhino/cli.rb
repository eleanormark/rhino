require "slop"

module Rhino

  # A wrapper for command line interaction that encompasses option parsing, version, help, and execution. This class is
  # instantiated from the binary. The class also handles bootstrapping the launcher.
  #
  # Usage:
  #
  #   cli = Rhino::CLI.new
  #   cli.parse()
  #
  class CLI
    BANNER = "usage: rhino [options] [./config.ru]".freeze

    def parse(items = ARGV)
      config = Slop.parse(items) do |options|
        options.banner = BANNER

        options.on "-h", "--help", 'help' do
          return help(options)
        end

        options.on "-v", "--version", 'version' do
          version
          exit
        end

        options.string "-b", "--bind", 'bind (default: 0.0.0.0)', default: "0.0.0.0"
        options.integer "-p", "--port", 'port (default: 5000)', default: 5000
        options.integer "--backlog", 'backlog (default: 64)', default: 64
        options.boolean "--reuseaddr", 'reuseaddr (default: true)', default: true
      end

      run(config)
    end

  private

    def help(options)
      Rhino.logger.log("#{options}")
    end

    def version
      Rhino.logger.log("#{VERSION}")
    end

    def run(options)
      config, _ = options.arguments
      Launcher.new(options[:port], options[:bind], options[:reuseaddr], options[:backlog], config || './config.ru').run
    end

  end
end
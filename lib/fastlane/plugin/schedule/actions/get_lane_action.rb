require 'fastlane/action'
require_relative '../helper/schedule_helper'

require 'yaml'

module Fastlane
  module Actions
    class GetLaneAction < Action
      def self.run(params)
        schedule = YAML.load_file('./fastlane/schedule.yml')
        time = Time.now
        wday = time.wday
        todayActions = schedule[wday]
        if todayActions.nil?
          return everyday_action
        end
        hour = time.hour
        action = todayActions[hour]
        if action.nil?
          return everyday_action
        end
        action['lane']
      end

      def self.everyday_action
        schedule = YAML.load_file('./fastlane/schedule.yml')
        everydayActions = schedule['everyday']
        if everydayActions.nil?
          return nil
        end
        time = Time.now
        hour = time.hour
        action = everydayActions[hour]
        if action.nil?
          return nil
        end
        return action['lane']
      end

      def self.description
        "Run lane from current time"
      end

      def self.authors
        ["marumemomo"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Run lane from current time"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "SCHEDULE_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end

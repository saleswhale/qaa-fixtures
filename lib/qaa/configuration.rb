require 'yaml'

#all methods in here are singleton methods
module Qaa
  class Configuration

    def self.config
      @config ||= {}
    end

    def self.load(profile_name, file_path, reset=false)
      begin
        new_config = YAML.load(ERB.new(File.read(file_path)).result)[profile_name]
        @config = {} if reset
        merge_env_variables(new_config)
        config_merge!(new_config)
      rescue Exception => e
        raise "Could not locate a configuration named \"#{profile_name}\" in \"#{file_path}\", #{e.message}"
      end
    end

    def self.merge_env_variables(new_config)
      new_config.each do |key, value|
        unless ENV[key].nil?
          new_config[key] = ENV[key]
        end
      end
    end

    def self.fetch (key, default='')
      if self.has_key? key
        self.[] key
      else
        default
      end
    end

    private

    def self.deep_merge! (key, value)
      if value.is_a?(Hash)
        value.each_pair do |k, v|
          self.deep_merge! "#{key}.#{k}", v
        end
      else
        self.[]= key, value
      end
    end


    def self.[]= (key, value)
      cur       = config
      key_parts = key.split('.')
      key_parts[0..-2].each do |key_part|
        if (!cur.has_key? key_part) || cur[key_part].nil?
          cur[key_part] = {}
        end
        cur = cur[key_part]
      end
      cur[key_parts.last] = value
    end

    def self.[] (key)
      if config.has_key? key
        config[key]
      else
        cur = config
        key.split('.').each do |key_part|
          if cur.has_key? key_part
            cur = cur[key_part]
          else
            return nil
          end
        end
        cur
      end
    end

    def self.has_key? (key)
      if config.has_key? key
        true
      else
        cur = config
        key.split('.').each do |key_part|
          if cur && (cur.has_key? key_part)
            cur = cur[key_part]
          else
            return false
          end
        end
        return true
      end
    end


    def self.config_merge! (config_hash)
      config_hash.each_pair do |k, v|
        self.deep_merge! k, v
      end
    end
  end

end

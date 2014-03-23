require 'redis'

class Counterfeiter
  @REDIS_SET='Counterfeiter'

  def self.upload_new_files target_dir, last_update = Time.at(0)
    Dir.glob(File.join(target_dir,'**/*')).each do |f|
      if File.file?(f) && File.mtime(f) > last_update
        upload_file_to_redis(f,File.mtime(f).to_i)
      end
    end
  end

  def self.config_redis host = "127.0.0.1", port = 6379
    @redis = Redis.new(host: host, port: port)
  end

  def self.upload_file_to_redis file, time
    @redis.zadd @REDIS_SET, time, File.read(file)
  end

  def self.download_new_files last_update = Time.at(0)
    files = @redis.zrangebyscore(@REDIS_SET, last_update.to_i, Time.now.utc.to_i)
    puts files
  end

  # def __get_new_files target_dir, last_update=Time.at(0)
  #   files = []
  #   Dir.glob(File.join(target_dir,'**/*')) do |f|
  #     files << f if File.mtime(f) > last_update
  #   end
  #   return files
  # end
end

require 'redis'
require 'fileutils'

class Counterfeiter
  @redis_key='Counterfeiter'

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
    @redis.zadd @redis_key, time, {path:file, body: File.read(file)}
  end

  def self.download_new_files target_dir = '.', last_update = Time.at(0)
    files = @redis.zrangebyscore(@redis_key, last_update.to_i, Time.now.utc.to_i)
    files.each do |f|
      path = File.join(target_dir,eval(f)[:path])
      FileUtils.mkdir_p File.dirname(path)
      File.open(File.realdirpath(path), 'w') { |file| file.write(eval(f)[:body]) }
    end
  end
end

module UsersHelper
  require 'net/http'
  require 'digest/md5'

  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    is_gravatar = gravatar?(user.email)
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    #gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def gravatar?(email, options = {})
    hash = Digest::MD5.hexdigest(email.to_s.downcase)
    options = { :rating => 'x', :timeout => 2 }.merge(options)
    http = Net::HTTP.new('www.gravatar.com', 80)
    http.read_timeout = options[:timeout]
    response = http.request_head("/avatar/#{hash}?rating=#{options[:rating]}&default=http://gravatar.com/avatar")
    response.code != '302'
    rescue StandardError, Timeout::Error
    true  # Don't show "no gravatar" if the service is down or slow
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  
end

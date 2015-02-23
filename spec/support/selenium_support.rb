class Selenium::WebDriver::Element
  alias_method :send_keys_orig, :send_keys
  def send_keys(*args, clear_flag: false)
    clear if clear_flag
    send_keys_orig(*args)
  end
end
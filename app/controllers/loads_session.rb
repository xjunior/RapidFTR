module LoadsSession

  def logged_in?
    !get_session.nil?
  end

  def current_user
    @current_user ||= User.find_by_user_name(current_user_name)
  end

  def current_user_name
    session = app_session
    return session.user_name unless session.nil?
  end

  def is_admin?
    session = Session.get_from_cookies(cookies)
    return session.admin? if session 
  end

  def is_admin?
    session = Session.get_from_cookies(cookies)
    user = User.find_by_user_name session.user_name
    !user.user_type.eql?('User')
  end

  private

  def get_session
    token = token_from_request
    return nil if token.nil?
    Session.get(token_from_request)
  end

  def token_from_request
    pull_token_from_headers || pull_token_from_cookies
  end

  def pull_token_from_headers
    authorization_header = request.headers['Authorization']
    return nil if authorization_header.nil?
    authorization_header[/^RFTR_Token (.*)/, 1]
  end

  def pull_token_from_cookies
    cookies[Session::COOKIE_KEY]
  end

end

# frozen_string_literal: true

require "pwned/password_base"

module Pwned
  ##
  # This class represents a hashed password. It does all the work of talking to the
  # Pwned Passwords API to find out if the password has been pwned.
  # @see https://haveibeenpwned.com/API/v2#PwnedPasswords
  class HashedPassword
    include PasswordBase
    ##
    # Creates a new hashed password object.
    #
    # @example A simple password with the default request options
    #     password = Pwned::HashedPassword.new("ABC123")
    # @example Setting the user agent and the read timeout of the request
    #     password = Pwned::HashedPassword.new("ABC123", headers: { "User-Agent" => "My user agent" }, read_timout: 10)
    #
    # @param hashed_password [String] The hash of the password you want to check against the API.
    # @param [Hash] request_options Options that can be passed to +Net::HTTP.start+ when
    #   calling the API
    # @option request_options [Symbol] :headers ({ "User-Agent" => "Ruby Pwned::Password #{Pwned::VERSION}" })
    #   HTTP headers to include in the request
    # @raise [TypeError] if the password is not a string.
    # @since 1.1.0
    def initialize(hashed_password, request_options={})
      raise TypeError, "hashed_password must be of type String" unless hashed_password.is_a? String
      @hashed_password = hashed_password.upcase
      @request_options = Hash(request_options).dup
      @request_headers = Hash(request_options.delete(:headers))
      @request_headers = DEFAULT_REQUEST_HEADERS.merge(@request_headers)
    end
  end
end

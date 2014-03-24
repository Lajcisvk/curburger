#encoding:utf-8

module Curburger

  module Cookies

    def parse_cookies header_content
      cookies, cookies_string = {}, ''
      if !header_content.empty? && header_content['Set-Cookie']
        header_content['Set-Cookie'].each{|c|
          cookies = get_cookie(c, cookies)
        } if header_content['Set-Cookie'].kind_of?(Array)
        cookies = get_cookie(header_content['Set-Cookie'], cookies) if
          header_content['Set-Cookie'].kind_of?(String)
      end
      otpt = ''
      cookies.dup.each{|k,v| otpt += "#{k}=#{v}; " }
      {cookies: cookies, cookies_string: otpt.squeeze(' ')}
    end

    private

    def get_cookie c, cookies
      c.split(';').each{|v|
        next unless v.match(/\=/)
        cookies[v.split('=')[0].strip] = v.split('=')[1].strip
      }
      cookies
    end

  end

end


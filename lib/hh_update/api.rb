require 'singleton'
require 'json'

module HHUpdate
  class API
    include Singleton

    HOST = 'https://api.hh.ru'

    def me
      jsonify(conn.get('me'))
    end

    def resumes
      resp = conn.get('resumes/mine')
      jsonify(resp) do |json|
        json['items'].map do |item|
          { id: item['id'], title: item['title'], url: item['alternate_url'] }
        end
      end
    end

    def update_resume(id)
      $logger.debug('update resume %s' % id)
      path = '/resumes/%s/publish' % id
      conn.post(path).tap do |resp|
        $logger.debug(resp)
      end
    end

    private

    def conn
      @conn ||= Faraday.new(url: HOST) do |faraday|
        # faraday.use Faraday::Response::Logger
        faraday.headers['Authorization'] = auth_header
        faraday.adapter Faraday.default_adapter
      end
    end

    def auth_header
      'Bearer %s' % ENV['ACCESS_TOKEN']
    end

    def jsonify(resp)
      json = JSON.parse(resp.body)
      if block_given?
        yield json
      else
        json
      end
    end
  end
end

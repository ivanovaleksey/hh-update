require 'singleton'
require 'json'

module HHUpdate
  class API
    include Singleton

    HOST = 'https://api.hh.ru'

    def me
      jsonify(conn.get('me'))
    end

    def resume_ids
      resp = conn.get('resumes/mine')
      jsonify(resp) do |json|
        json['items'].map { |item| item['id'] }
      end
    end

    def update_resume(id)
      path = '/resumes/%s/publish' % id
      resp = conn.post(path)
    end

    private

    def conn
      @conn ||= Faraday.new(url: HOST) do |faraday|
        faraday.use Faraday::Response::Logger
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

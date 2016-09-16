require 'singleton'

module HHUpdate
  class Notifier
    include Singleton

    def initialize
      @obj = Slack::Notifier.new ENV['SLACK_WEBHOOK'], username: 'HH update'
    end

    def success(resume)
      @obj.ping(
        attachments: [{
          fallback: 'Your resume was succesfully updated',
          title: "#{resume[:title]}",
          title_link: "#{resume[:url]}",
          color: '#7CD197',
          fields: [{
            title: 'Status',
            value: 'Updated'
          }]
        }]
      )
    end
  end
end

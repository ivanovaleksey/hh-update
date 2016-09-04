module HHUpdate
  class Script
    def initialize
      @api = API.instance
      @notifier = Notifier.instance
    end

    def call
      $logger.info('start')
      update_resumes
      $logger.info('done')
    end

    private

    def update_resumes
      @api.resumes.each do |resume|
        resp = @api.update_resume resume[:id]
        @notifier.success(resume) if resp.status == 204
      end
    end
  end
end

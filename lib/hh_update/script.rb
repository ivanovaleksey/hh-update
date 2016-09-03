module HHUpdate
  class Script
    def initialize
      @api = API.instance
    end

    def call
      $logger.info('start')
      update_resumes
      $logger.info('done')
    end

    private

    def update_resumes
      @api.resume_ids.each do |id|
        @api.update_resume(id)
      end
    end
  end
end

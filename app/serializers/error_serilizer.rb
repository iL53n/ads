module ErrorSerializer
  extend self

  def error_response(object)
    { errors: build_errors(object.errors) }.to_json
  end

  private

  def build_errors(errors)
    errors.map do |e|
      {
        detail: e.full_message,
        source: {
          pointer: "/data/attributes/#{e.attribute}"
        }
      }
    end
  end
end

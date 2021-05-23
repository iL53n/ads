require 'dry/initializer'
require_relative 'api'

module AuthService
  class Client
    extend Dry::Initializer[undefined: false]
    include Api

    # option :url, default: proc { 'http://localhost:3010/v1' }
    # option :connection, default: proc { build_connection }
    option :channel, default: proc { RabbitMQ.channel }
    option :exchange, default: proc { channel.default_exchange }
    option :reply_queue, default: proc { create_reply_queue }
    option :lock, default: proc { Mutex.new }
    option :condition, default: proc { ConditionVariable.new }
    option :response, default: proc { set_response }

    def publish(payload, opts = {})
      @lock.synchronize do
        self.correlation_id = SecureRandom.uuid

        @exchange.publish(
          payload,
          opts.merge(
            routing_key: 'auth',
            correlation_id: @correlation_id,
            reply_to: @reply_queue.name,
            headers: {
              request_id: Thread.current[:request_id]
            }
          )
        )

        @condition.wait(@lock)
      end

      @response
    end

    private

    attr_writer :response, :correlation_id

    def create_reply_queue
      @channel.queue('', exclusive: true)
    end

    def set_response
      self.correlation_id = SecureRandom.uuid

      @reply_queue.subscribe do |delivery_info, properties, payload|
        if properties[:correlation_id] == @correlation_id
          self.response = JSON(payload)['user_id']

          @lock.synchronize { @condition.signal }
        end
      end
    end
  end
end

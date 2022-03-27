# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class BaseInteractor
  include Dry::Monads[:result, :do]
  include Dry::Monads::Do.for(:call)

  def call; end;
end

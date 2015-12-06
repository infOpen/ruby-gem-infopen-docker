##
# This module reference error classes for this gem

module Infopen::Docker::Error

    ##
    # Default error, not raised but can be used to catch gem specific errors

    class InfopenDockerError < StandardError; end

    ##
    # Used in case of methods argument errors

    class ArgumentError < InfopenDockerError; end

    ##
    # Used if docker image not exists

    class ImageError < InfopenDockerError; end

end


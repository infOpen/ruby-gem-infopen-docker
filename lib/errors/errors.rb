# This module reference error classes for this gem

module Infopen::Docker::Error

    # Default error, not raised but can be used to catch gem specific errors
    class InfopenDockerError < StandardError; end

    # Argument errors
    class ArgumentError < InfopenDockerError; end

    # Image errors
    class ImageError < InfopenDockerError; end

end


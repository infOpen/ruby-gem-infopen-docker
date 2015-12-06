##
# This module contains tests about docker images and containers lifecycle

module Infopen::Docker::Lifecycle

    require 'docker'
    include Infopen::Docker::Error


    ##
    # Remove image and its containers.
    #
    # Raise an ArgumentError if bad param number
    #
    # Raise an Infopen::Docker::ArgumentError if param is not a
    # Docker::Image instance
    #
    # Raise an Infopen::Docker::ImageError if image not exists

    def self.remove_image_and_its_containers(image_obj)

        # Check param
        unless image_obj.is_a?(Docker::Image)
            raise ArgumentError, "Expected a Docker::Image, got: #{image_obj}."
        end

        # Get and remove all containers linked to image
        get_containers_from_image_id(image_obj.id).each do |container|
            Docker::Container.get(container.id).remove(:force => true)
        end

        # Remove image
        image_obj.remove(:force => true)
    end


    ##
    # Get all containers created with image id param.
    #
    # It's a private module method.
    #
    # Raise an ArgumentError if bad param number
    #
    # Raise an Infopen::Docker::ArgumentError if param is not a
    # Docker::Image instance
    #
    # Raise an Infopen::Docker::ImageError if image not exists

    def self.get_containers_from_image_id (image_id)

        # Check param type
        unless image_id.is_a?(String) and image_id.length != 0
            raise ArgumentError, "Expected not empty string, got: #{image_id}."
        end

        # Check image is valid
        begin
            image = Docker::Image.get(image_id)
        rescue Docker::Error::NotFoundError
            raise ImageError, "Image #{image_id} not exists."
        end

        Docker::Container.all(:all => true).select { |container|
            container
                .info['Image']
                .start_with?(image.id)
        }
    end
    private_class_method :get_containers_from_image_id

end


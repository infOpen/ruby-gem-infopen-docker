require 'docker'
require 'infopen-docker'
require 'rspec'

describe 'Infopen::Docker::Lifecycle' do


    describe 'remove_image_and_its_containers' do

        before(:all) do
            @image = Docker::Image.create('fromImage' => 'hello-world')

            # Run a command to launch a container
            @image.run('/hello')
        end

        it 'thrown an error without parameter' do
            expect {
                Infopen::Docker::Lifecycle
                    .remove_image_and_its_containers()
            }.to raise_error(ArgumentError)
        end

        it 'thrown an error with a bad parameter' do
            expect {
                Infopen::Docker::Lifecycle
                    .remove_image_and_its_containers(nil)
            }.to raise_error(Infopen::Docker::Error::ArgumentError)
        end

        it 'should remove image with valid Docker::Image with container' do
            expect(
                Infopen::Docker::Lifecycle
                    .remove_image_and_its_containers(@image)
            ).to be_truthy
            .and include( '{"Untagged":"hello-world:latest"}' )
            .and include( '{"Deleted":' )
        end
    end

    describe 'get_containers_from_image_id' do

        before(:all) do
            @image = Docker::Image.create('fromImage' => 'hello-world')

            # Run a command to launch a container
            @image2 = Docker::Image.create('fromImage' => 'hello-world')
            @container = @image2.run('/hello')
        end

        after(:all) do
            @container.delete(:force => true)
            @image.remove(:force => true)
        end

        it 'thrown an error without parameter' do
            expect {
                Infopen::Docker::Lifecycle
                    .send(:get_containers_from_image_id)
            }.to raise_error(ArgumentError)
        end

        it 'thrown an error with a bad parameter' do
            expect {
                Infopen::Docker::Lifecycle
                    .send(:get_containers_from_image_id, nil)
            }.to raise_error(Infopen::Docker::Error::ArgumentError)
        end

        it 'thrown an error with a bad image identifier' do
            expect {
                Infopen::Docker::Lifecycle
                    .send(:get_containers_from_image_id, 'foo')
            }.to raise_error(Infopen::Docker::Error::ImageError)
        end

        it 'should return an empty array with an image without container' do
            containers = Infopen::Docker::Lifecycle
                              .send(:get_containers_from_image_id, @image.id)
            expect(containers).to be_an_instance_of(Array)
            expect(containers.length).to be_eql(1)
        end

        it 'should return a container array with an image with container' do
            containers = Infopen::Docker::Lifecycle
                              .send(:get_containers_from_image_id, @image2.id)
            expect(containers).to be_an_instance_of(Array)
            expect(containers.length).to be_eql(1)
        end
    end
end


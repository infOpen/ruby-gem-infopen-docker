Gem::Specification.new do |spec|

    # Common informations
    spec.name        = 'infopen-docker'
    spec.version     = '0.2.1'
    spec.date        = '2015-12-06'
    spec.summary     = 'Docker common functions'
    spec.description = 'Used to add common functions for Dockerfile tests'
    spec.authors     = [ 'Alexandre Chaussier' ]
    spec.email       = 'a.chaussier@infopen.pro'
    spec.files       = [ 'lib/infopen-docker.rb',
                         'lib/docker/lifecycle.rb',
                         'lib/errors/errors.rb'
                       ]
    spec.homepage    = 'https://github.com/infOpen/ruby-gem-infopen-docker'
    spec.license     = 'MIT'

    # Development ependencies
    spec.add_development_dependency 'rake',   '~> 10.4', '>= 10.4.2'
    spec.add_development_dependency 'rspec',  '~> 3.4',  '>= 3.4.0'

    # Runtime dependencies
    spec.add_runtime_dependency 'docker-api', '~> 1.24', '>= 1.24.0'
end


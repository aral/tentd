module TentServer
  class API
    class Apps
      include Router

      class GetOne < Middleware
        def action(env)
          if app = TentServer::Model::App.get(env.params.app_id)
            env.response = app.as_json(:only => [:id, :name, :description, :url, :icon, :redirect_uris, :scopes, :mac_key_id])
          end
          env
        end
      end

      class GetAll < Middleware
        def action(env)
          env.response = TentServer::Model::App.all
          env
        end
      end

      class Create < Middleware
        def action(env)
          env.response = TentServer::Model::App.create_from_params(env.params.data).as_json(:only => [:id, :name, :description, :url, :icon, :redirect_uris, :scopes, :mac_key_id, :mac_key, :mac_algorithm])
          env
        end
      end

      get '/apps/:app_id' do |b|
        b.use GetOne
      end

      get '/apps' do |b|
        b.use GetAll
      end

      post '/apps' do |b|
        b.use Create
      end
    end
  end
end

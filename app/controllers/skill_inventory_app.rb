class SkillInventoryApp < Sinatra::Base
  set :root, File.expand_path('..', __dir__)
  set :method_override, true

  get '/' do
    haml :dashboard
  end

  get '/skills' do
    @skills = SkillInventory.all
    haml :index
  end

  get '/skills/:id' do |id|
    @skill = SkillInventory.find(id)
    haml :show_skill
  end
end

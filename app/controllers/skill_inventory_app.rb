class SkillInventoryApp < Sinatra::Base
  set :root, File.expand_path('..', __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/skills' do
    @skills = SkillInventory.all
    erb :index
  end

  get '/skills/:id' do |id|
    @skill = SkillInventory.find(id)
    erb :show_skill
  end
end

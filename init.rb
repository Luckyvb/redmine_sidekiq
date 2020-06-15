require 'redmine_sidekiq/configure'
require 'redmine_sidekiq/rails'

Redmine::Plugin.register :redmine_sidekiq do
  name 'Redmine Sidekiq plugin'
  description 'This is a Sidekiq plugin for Redmine'
  version '2.1.0'
  url 'https://github.com/ogom/redmine_sidekiq'
  author_url 'mailto:ogom@hotmail.co.jp'
  author 'ogom'

  I18n.load_path += Dir[Rails.root.join("config","locales","*.yml")]
  I18n.load_path += Dir[Rails.root.join("plugins","redmine_sidekiq","config","locales","*.yml")]
  I18n.locale = !User.current.language.blank? ? User.current.language : Setting.default_language
  if Redmine::Plugin::registered_plugins.include?(:fontawesome)
    menu :top_menu, :sidekiq, '/sidekiq', :caption => '', :html => {:class => 'fa fa-stream', :title => I18n.t('redmine_sidekiq.title') }, :after => :projects, :if => Proc.new {User.current.admin}
  else
    menu :top_menu, :sidekiq, '/sidekiq', :caption => :sidekiq, :html => {:class => 'icon icon-only icon-plugins', :title => 'SideKiq'}, :after => :projects, :if => Proc.new {User.current.admin}
  end
end

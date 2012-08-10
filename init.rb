require 'redmine' if Redmine::VERSION::MAJOR <= 1
require 'query_pulldown_hook'
require 'query_pulldown_menu_helper_patch'

Redmine::Plugin.register :redmine_query_pulldown do
  name 'Redmine Query Pulldown plugin'
  author 'OZAWA Yasuhiro'
  description 'Insert custom queries link on issues link'
  version '0.0.2'
  url 'https://github.com/ameya86/redmine_query_pulldown'
  author_url 'http://blog.livedoor.jp/ameya86/'
end

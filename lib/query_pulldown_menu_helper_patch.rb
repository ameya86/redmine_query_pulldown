require_dependency 'redmine/menu_manager'

module QueryPulldownMenuHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods) # obj.method

    base.class_eval do
      alias_method_chain :render_menu, :query_pulldown
    end
  end

  module InstanceMethods # obj.method
    # プロジェクトメニューの「チケット」の下に
    # カスタムクエリを表示させる
    def render_menu_with_query_pulldown(menu, project = nil)
      if :project_menu == menu
        links = []
        menu_items_for(menu, project) do |node|
          menu_node = render_menu_node(node, project)
          if 'issues' == node.html_options[:class] && project && !project.queries.empty?
            menu_node.slice!(-5, 5) # 末尾の</li>を削る
            links << menu_node

            query_id = @query && @query.id
            queries = queries = Query.visible.all(
                :order => "#{Query.table_name}.name ASC",
                :conditions => ["project_id = ?", project.id])

            links << '<ul>'
            queries.each do |query|
              str = "<li>"
              str << link_to(query.name, {:controller => 'issues', :action => 'index', :query_id => query.id}, :class => (query.id == query_id)? 'selected' : '')
              str << "</li>"
              links << str
            end
            links << '</ul>'
            links << '</li>'
          else
            links << menu_node
          end
        end
        links.empty? ? nil : content_tag('ul', links.join("\n").html_safe)
      else
        return render_menu_without_query_pulldown(menu, project)
      end
    end
  end
end

Redmine::MenuManager::MenuHelper.send(:include, QueryPulldownMenuHelperPatch)

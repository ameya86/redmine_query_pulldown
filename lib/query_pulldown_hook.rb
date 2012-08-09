class QueryPulldownHook < Redmine::Hook::ViewListener
  render_on :view_layouts_base_html_head, :partial => 'query_pulldowns/html_head'
end

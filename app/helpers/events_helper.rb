module EventsHelper


  def render_event(object)
    case object.key
    when 'todo.create'
      content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 创建了任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
    when 'todo.update'
      parameters_html(object).join.html_safe
    when 'comment.create'
      content_tag :div, class: 'event-list', 'data-id': object.id do
        concat "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 回复了任务: #{object.sender.todo.name}"
        concat(content_tag :p, "#{object.sender.content}")
      end
    end
  end


  def parameters_html(object)
     object.parameters.collect do |k, v|
      case k
      when 'user_id'
        if v.first && v.last
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 把#{User.find(v.first).name}任务指派给了#{User.find(v.last).name}: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        elsif v.first
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 取消了#{User.find(v.first).name}的任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        elsif v.last
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 给#{User.find(v.last).name}指派了任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        end
      when 'state'
        if v.first
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 取消了任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        else
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 完成了任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        end
      when 'finish_at'
        if v.first
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 将任务完成时间从#{v.first.strftime("%m月%d日")}修改为 #{v.last.strftime("%m月%d日")}: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        else
          content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name}将任务完成时间从 没有截止日期 修改为 #{v.last.strftime("%m月%d日")}: #{object.sender.name}", class: 'event-list', 'data-id': object.id
        end
      when 'is_delete'
        content_tag :div, "#{object.created_at.strftime("%H:%M")} #{object.owner.name} 删除了任务: #{object.sender.name}", class: 'event-list', 'data-id': object.id
      end
    end
  end
end

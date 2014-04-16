module MicropostsHelper
  def nested_microposts(microposts)
    microposts.map do |post, sub_post|
      render(post) + content_tag(:div, nested_microposts(sub_post), class: "nested_microposts")
    end.join.html_safe
  end
end
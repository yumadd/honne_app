json.extract! post, :id, :content, :bg_color, :created_at, :updated_at
json.url post_url(post, format: :json)

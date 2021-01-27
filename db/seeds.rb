10.times.each do |n|
  Task.create!(
    title: "タスクタイトル#{n + 1}",
    description: "タスクの詳細内容を記載します(#{n + 1})。",
    is_done: false
  )
end
puts 'タスク作成！'

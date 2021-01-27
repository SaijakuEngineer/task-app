class TasksController < ApplicationController
  def index
    # 未達成タスクの取得
    @not_done_tasks = Task.where(is_done: false)
    # 達成タスクの取得
    @done_tasks = Task.where(is_done: true)
    # タスク登録に必要なオブジェクト作成
    @task = Task.new
  end

  def create
    # タイトルと説明が入力されているか確認
    if params[:task][:title].blank? || params[:task][:description].blank?
      # フラッシュメッセージに文言代入
      flash[:danger] = 'タイトル・説明欄、両方入力してください。'
      # タスク一覧ページへ移動
      redirect_to tasks_path and return
    end
    # タスク登録オブジェクトの中身を代入
    @task = Task.new(
      title: params[:task][:title],
      description: params[:task][:description]
    )
    # タスク登録(作成)
    @task.save

    # フラッシュメッセージを代入
    flash[:success] = 'タスクを登録しました。'
    # タスク一覧画面へ移動
    redirect_to tasks_path  
  end

  def delete
    # 該当タスクを取得
    @task = Task.find_by(id: params[:task_id])
    # 該当タスクを削除
    @task.destroy
    # flashメッセージに文言代入
    flash[:danger] = 'タスクを削除しました。'
    # タスク一覧ページへ移動
    redirect_to tasks_path
  end

  def update
    # 該当タスク取得
    task = Task.find_by(id: params[:task][:id])
    # 該当タスクを更新
    task.update(
      title: params[:task][:title],
      description: params[:task][:description]
    )

    # チェックボックスの有無を確認
    if params[:is_done].present?
      # チェックボックスの中身一覧を変数に代入
      is_dones = params[:is_done]
      # 該当するタスクを検索
      tasks = Task.where(id: is_dones.keys)
      # 該当するタスクを1つ1つ更新
      tasks.each do |task|
        task.update(is_done: is_dones[:"#{task.id}"])
      end
    end

    # フラッシュメッセージに文言代入
    flash[:success] = '選択したタスクを更新しました。'
    # タスク一覧ページへ移動
    redirect_to tasks_path
  end
end

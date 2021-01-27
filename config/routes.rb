Rails.application.routes.draw do
  get 'tasks', to: 'tasks#index'

  post 'task_create', to: 'tasks#create', as: 'task_create'
  patch 'task_update', to: 'tasks#update'
  delete 'task/:task_id', to: 'tasks#delete', as: 'task_delete'
end

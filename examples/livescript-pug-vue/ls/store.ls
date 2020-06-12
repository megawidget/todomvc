const STORAGE_KEY = 'todos-vuejs'

window.todoStorage =
  fetch: -> JSON.parse localStorage.getItem(STORAGE_KEY) || '[]'
  save: (todos) -> localStorage.setItem STORAGE_KEY, JSON.stringify todos

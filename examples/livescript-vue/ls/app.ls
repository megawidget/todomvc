filters =
  all: (todos) -> todos
  active: (todos) -> todos.filter (todo) -> !todo.completed
  completed: (todos) -> todos.filter (todo) -> todo.completed

window.app = new Vue do
  el: '.todoapp'
  data:
    todos: todoStorage.fetch!
    newTodo: ''
    editedTodo: null
    visibility: 'all'
  watch:
    todos:
      deep: true
      handler: todoStorage.save
  computed:
    filteredTodos: -> filters[@visibility](@todos)
    remaining: -> filters.active(@todos).length
    allDone:
      get: -> @remaining == 0
      set: (value) -> @todos.forEach (todo) -> todo.completed = value
  methods:
    pluralize: (word, count) -> word + (count == 1 ? '' : 's')
    addTodo: ->
      value = @newTodo && @newTodo.trim!
      unless value
        return
      @todos.push id: @todos.length + 1, title: value, completed: false
      @newTodo = ''
    removeTodo: (todo) -> @todos.splice @todos.indexOf(todo), 1
    editTodo: (todo) ->
      @beforeEditCache = todo.title
      @editedTodo = todo
    doneEdit: (todo) ->
      unless @editedTodo
        return
      @editedTodo = null
      todo.title = todo.title.trim!
      unless todo.title
        @removeTodo todo
    cancelEdit: (todo) ->
      @editedTodo = null
      todo.title = @beforeEditCache
    removeCompleted: -> @todos = filters.active(@todos)
  directives:
    'todo-focus': (el, binding) -> el.focus! if binding.value

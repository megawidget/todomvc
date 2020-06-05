router = new Router!

['all', 'active', 'completed'].forEach (visibility) ->
  router.on visibility, -> app.visibility = visibility

router.configure do
  notfound: ->
    window.location.hash = ''
    app.visibility = 'all'

router.init!

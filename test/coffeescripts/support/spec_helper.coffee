# Add "context" and "xcontent" functions which just act as aliases for "describe" and "xdescribe"
window.context = (description, specDefinitions) ->
  describe(description, specDefinitions)

window.xcontext = (description, specDefinitions) ->
  xdescribe(description, specDefinitions)

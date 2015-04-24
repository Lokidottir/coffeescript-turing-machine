###
  turing-ui.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringRenderer} = require("./turing-renderer")
{TuringTape}     = require("./turing-tape")
{TuringParser}   = require("./turing-parser")

###
  This portion of the program assumed jquery ($) is defined within scope
###

class TuringUI
  uuid:         null # uuid for the ui
  mainID:       null # ID for the UI wrapper
  renderer:     null # Renderer
  tapeInputID:  null # Initial tape set ID
  textInputID:  null # Input program to parse ID
  pauseCheckID: null # Pause turing machine checkbox ID
  apsID:        null # Actions per second input ID

  constructor: (@mainID, width = 1000, height = 700, renderRatio = 0.8) ->
    @uuid = TuringUI.genID()
    loc = document.getElementById(@mainID)
    loc.innerHTML = "<em>butts</em>"
    #@initRenderer()
    #@initTextInput()
    #@initConfigInputs()

  @genID = (length = 32) ->
    id = ""
    id += (Math.floor(Math.random() * 123.5711).toString(16).substring(0,1)) for i in [0..length-1] by 1
    return id


module.exports = {TuringUI}

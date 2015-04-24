###
  turing-renderer.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringTape}    = require("./turing-tape")
{TuringMachine} = require("./turing-machine")
{Clock}         = require("./helper-clock")

class TuringRenderer
  context:             null # The context for the turing machine
  turingMachine:       null # The turing machine wrapped by the renderer
  turingTape:          null # The turing tape to feed to the machine
  actionsPerSecond:    null # The number of actions that the machine will perform each second
  timeUntilNextAction: null # The time until the next action
  size:                null # The size of rendered components (eg. width of a tape segment)
  previousTapeIndex:   0    # The previous index of the turing machine
  machineIsPaused:     true # Boolean toggle for pausing the machine
  x:                   null
  y:                   null

  constructor: (@context, @turingMachine, @actionsPerSecond, @size, symbols = 2) ->
    @timeUntilNextAction = 1.0/parseFloat(@actionsPerSecond)
    @turingTape = new TuringTape(symbols)
    @x = @context.width/2.0
    @y = @context.height/2.0

  update: (clock) ->
    if not @machineIsPaused then @doSteps(clock)

  doSteps: (clock) ->
    if not @turingMachine.halted
      @timeUntilNextAction -= clock.interval()
      while this.timeUntilNextAction <= 0.0 and not @turingMachine.halted
        @previousTapeIndex = @turingMachine.tapeIndex
        @turingMachine.step(@turingTape)
        @timeUntilNextAction += (1.0/@actionsPerSecond)

  display: (clock) ->
    @context.save()
    @context.translate(@size/2, @size/2)
    @displayHead(clock)
    @displayTape(clock)
    @displayStateDetails(clock)
    @context.restore()

  displayHead: (clock) ->
    @context.save()

    @context.restore()

  displayTape: (clock) ->
    @context.save()
    @context.translate(0,@size * 1.5)
    segDisplayCount = Math.ceil(@context.width/@size)
    startingIndex = @turingMachine.tapeIndex - Math.ceil(bitDisplayCount / 2)
    endingIndex = startingIndex + segDisplayCount
    temportalOffset = @calculateMovementOffset()
    @context.fillStyle = "#ffffff"
    @context.strokeStyle = "#000000"
    for i in [startingIndex..endingIndex] by 1
      @context.save()
      @context.translate(-(segDisplayCount/2) * @size + ((i - startingIndex) * @size) + temportalOffset, 0)
      @context.fillRect(0,0,@size,@size)
      @context.fillText(@turingTape.read(i).toString(),@size/2,@size/2)
      @context.restore()
    @context.restore()

  calculateMovementOffset: () ->
    ((@timeUntilNextAction % (1.0/@actionsPerSecond)) *
      @size *
      (@turingMachine.tapeIndex - @previousTapeIndex) *
      @actionsPerSecond)

  displayStateDetails: () ->
    undefined

  decisionActionAsString: () ->
    undefined

  togglePaused: () ->
    @machineIsPaused = not @machineIsPaused

  pause: () ->
    @machineIsPaused = true

  unpause: () ->
    @machineIsPaused = false

  resetProgram: (program, resetTapeIndex = true) ->
    @pause()
    temp = 0
    if not resetTapeIndex
      temp = @turingMachine.tapeIndex
    else
    @turingMachine = new TuringMachine(program)
    @turingMachine.tapeIndex = temp


  resetTape: (symbols = @turingTape.symbols) ->
    @turingTape = new TuringTape(symbols)

  reset: (program, resetTapeIndex = true) ->
    @resetProgram(program, resetTapeIndex)
    @resetTape()

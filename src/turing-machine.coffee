###
  turing-machine.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{isHaltingState} = require "./turing-program"

MOVE = {
  GRADUAL: 0
  INSTANT: 1
}

DECISION = {
  WRITE: 0
  MOVE:  1
  GOTO:  2
}

class TuringMachine
  program:       null           # Program the turing machine is running
  statenum:      0              # The number of the state that the turning machine is executing
  decisionState: DECISION.WRITE # The Decision state of the turing machine (write/move/goto)
  symbolRead:    0              # The decsition mode of the turing machine ()
  tapeIndex:     0              # The index of the turing machine's head on the tape is acting on
  halted:        false          # If the machine is at a halting state, this is true
  moveMode:      MOVE.GRADUAL   # The movement state of the machine
  inMotion:      false          # Is the machine in motion
  movesMade:     0              # The number of moves made

  constructor: (@program) ->

  step: (tape, doOutput = false, output = console.log) ->
    if @halted or isHaltingState(@statenum) then return
    switch @decisionState
      when DECISION.WRITE
        @symbolRead = tape.read(@tapeIndex)
        tape.write(@program.getDecision(@).write)
        @decisionState = DECISION.MOVE
      when DECISION.MOVE
        if @moveMode == MOVE.INSTANT
          @tapeIndex += parseInt(@program.getDecision(@).move)
          @decisionState = DECISION.GOTO
        else
          movesNeeded = Math.abs(@program.getDecision(@).move)
          if movesNeeded > 0
            @tapeIndex += parseInt(@program.getDecision(@).move/movesNeeded)
            @movesMade++
          if @movesMade > movesNeeded
            @movesMade = 0
            @decisionState = DECISION.GOTO
      when DECISION.GOTO
        @statenum = @program.getDecision(@).goto
        @halted = isHaltingState(@statenum)
        @decisionState = DECISION.WRITE
    output("""
      symbol:   #{@symbolRead}
      decision: #{@decisionState}
      statenum: #{@statenum}
      moves:    #{@movesMade}
      index:    #{@tapeIndex}
    """) if doOutput
    @decisionState

  superstep: (tape, doOutput = false, output = console.log) ->
    if @halted then return
    else if @decisionState == DECISION.WITE
      @step(tape, doOutput, output)
      @superstep(tape, doOutput, output)
    else
      @step(tape, doOutput, output) while not halted and @decisionState != DECISION.WRITE
    return

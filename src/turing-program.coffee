###
  turing-program.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

# Function for testing if a state number is the halting state
isHaltingState = (statenum) -> statenum < 0

class TuringProgram
  symbols: null  # The number of symbols in the program
  states:  {}    # The states of the program

  constructor: (@symbols) ->

  getState: (statenum) ->
    @states[statenum]

  getDecision: (turingMachine) ->
    @getState(turingMachine.statenum).getDecision(turingMachine.symbolRead)

  add: (state) ->
    ###
      Add a new state to the program
    ###
    @states[state.statenum] = state

class TuringState
  statenum: null # The number of the state
  decisions: {}  # The list of states organised by statenum (0: <state 0>, etc.)

  constructor: (@statenum) ->

  add: (symbol, decision) ->
    ###
      Add a new decision to the state
    ###
    @decisions[symbol] = decision

  getDecision: (symbol) ->
    @decisions[symbol]

class TuringDecision
  write: null    # The write symbol
  move:  null    # The move number
  goto:  null    # The state to go to after moving

  constructor: (@write, @move, @goto) ->

  set: (@write, @move, @goto) ->

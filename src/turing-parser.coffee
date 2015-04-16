###
  turing-parser.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringProgram, TuringState, TuringDecision} = require "./turing-program.coffee"

PARSER = {
  COMMENT:  "(//.+)"
  STATENUM: "(@[0-9]+)"
  STATE:    "(#{PARSER.STATENUM}[^@]*(?=endif))(endif)"
  SYMBOLC:  "(\\#[0-9]+)"
  DECISION: "((((elseif)|(if)\\s+[0-9]+)[\\S\\s]*?)(?=((else([\\ i]?))|(endif))))"
  ELSEPART: "((else\\s*\\n)[\\S\\s]*?(?=endif))"
}

class TuringParser
  ###
    Turing Machine program parseing namespace

    The first argument is a string program, state, or decision to
    parse, the second argument is the errorlogger, a function that
    can take a string.
  ###
  @symbolCount: (programToParse) ->
    return parseInt(programToParse.match(///#{PARSER.SYMBOLC}///).substr(1))

  @parseProgram: (programToParse, log = console.log) ->
    workingSource = programToParse.replace(///#{PARSER.COMMENT}///g, "").replace(/(halt)/g, -1)
    program = new TuringProgram(TuringParser.symbolCount())
    stateList = workingSource.match(///#{PARSER.STATE}///g)
    for state in stateList
      maybeState = TuringParser.parseState(state)
      if maybeState != undefined then program.add(maybeState)
      else
        log("[TuringParser.parseProgram] state parsing returned undefined")
        return undefined
    log("[TuringParser.parseProgram] returning parsed program")
    return program

  @parseState: (stateToParse, stateCount, log = console.log) ->
    workingSource = stateToParse.replace(///#{PARSER.COMMENT}///g, "")
    state = new TuringState()
    decisionList = workingSource.match(///#{PARSER.DECISION}///g)
    for decision in decisionList
      maybeDecision = TuringParser.parseDecision(decision)
      if maybeDecision != undefined then state.add(maybeDecision.symbol, maybeDecision)
      else
        log("[TuringParser.parseState] decision parsing returned undefined")
        return undefined
    elseDecision = workingSource.match(///#{PARSER.ELSEPART}///g)
    parsedElse = TuringParser.parseDecision(elseDecision)
    if parsedElse != undefined
      for statenum in [0..stateCount-1] by 1
        if state.get(statenum) == undefined then state.add(statenum, parsedElse)







  @parseDecision: (decisionToParse, log = console.log) ->
    workingSource = decisionToParse.replace(///#{PARSER.COMMENT}///g, "")

module.exports = {TuringParser}

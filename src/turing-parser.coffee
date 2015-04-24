###
  turing-parser.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringProgram, TuringState, TuringDecision} = require "./turing-program"

PARSER =
  COMMENT:  "(//.+)"
  STATENUM: "(@[0-9]+)"
  STATE:    "((@[0-9]+)[^@]*(?=endif))(endif)"
  SYMBOLC:  "(\\#[0-9]+)"
  DECISION: "((((elseif)|(if)\\s+[0-9]+)[\\S\\s]*?)(?=((else([\\ i]?))|(endif))))"
  ELSEPART: "((else\\s*\\n)[\\S\\s]*?(?=endif))"

class TuringParser
  ###
    Turing Machine program parseing namespace

    The first argument is a string program, state, or decision to
    parse, the second argument is the logger, a function that
    can take a string intended to print output to somewhere.
  ###

  @preprocess: (source) ->
    source.replace(///#{PARSER.COMMENT}///g, "")
      .replace(/(halt)/gi, "-1")
      .replace(/(right)/gi, "+1")
      .replace(/(left)/gi, "-1")


  @symbolCount: (programToParse) ->
    return parseInt(programToParse.match(///#{PARSER.SYMBOLC}///).substr(1))

  @parseProgram: (programToParse, log = console.log) ->
    workingSource = @preprocess(programToParse)
    program = new TuringProgram(TuringParser.symbolCount())
    stateList = workingSource.match(///#{PARSER.STATE}///g)
    for state in stateList
      maybeState = TuringParser.parseState(state, program.symbols)
      if maybeState != undefined then program.add(maybeState)
      else
        log("[TuringParser.parseProgram] state parsing returned undefined")
        return undefined
    log("[TuringParser.parseProgram] returning parsed program")
    return program

  @parseState: (stateToParse, symbolCount, log = console.log) ->
    workingSource = @preprocess(stateToParse)
    statenum = parseInt(workingSource.match(///#{PARSER.STATENUM}///))
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
      for symbolnum in [0..symbolCount-1] by 1
        if state.get(symbolnum) == undefined then state.add(symbolnum, parsedElse)
    else
      log("[TuringParser.parseState] 'else' could not be parsed, assuming it wasn't present")
    log("[TuringParser.parseState] returning parsed state")
    return state

  @parseDecision: (decisionToParse, statenum, log = console.log) ->
    workingSource = @preprocess(decisionToParse)


module.exports = {TuringParser}

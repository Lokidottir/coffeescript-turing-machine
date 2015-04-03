###
  turing-parser.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringProgram, TuringState, TuringDecision} = require "./turing-program"

PARSER = {
  COMMENT:  "(//.+)"
  STATENUM: "(@[0-9]+)"
  STATE:    "(#{PARSER.STATENUM}[^@]*(?=endif))(endif)"
  SYMBOLC:  "(\\#[0-9]+)"
  IFPART:   "(((elseif)|(if))[\\S\\s]*(?=else[\\ i]))"
  ELSEPART: "((else))"
}

TuringParser = {
  ###
    Turing Machine program parseing namespace

    The first argument is a string program, state, or decision to
    parse, the second argument is the errorlogger, a function that
    can take a string.
  ###
  parseProgram: (programToParse, errorlog = console.log) ->
    workingSource = programToParse.replace(PARSER.COMMENT, "")
    

  parseState: (stateToParse, errorlog = console.log) ->
    workingSource = stateToParse.replace(PARSER.COMMENT, "")

  parseDecision: (decisionToParse, errorlog = console.log) ->
    workingSource = decisionToParse.replace(PARSER.COMMENT, "")
}

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

class TuringParser

    @parseProgram: (errorlog) -> (programToParse) ->
        workingSource = programToParse.replace()

    @parseState: (errorlog) -> (stateToParse) ->
        workingSource = stateToParse.replace()

    @parseDecision: (errorlog) -> (decisionToParse) ->

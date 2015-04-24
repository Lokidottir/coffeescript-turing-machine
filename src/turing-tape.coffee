###
  turing-tape.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

class TuringTape
  ###
    A class that represents an infinite bi-directional
    tape
  ###
  defaultSymbol: null    # The default symbol written to the tape
  symbols:       null    # The number of symbols supported by the tape ()
  postape:       []      # The positive tape, indexes >= 0
  negtape:       []      # The negative tape, indexes <= -1

  constructor: (@symbols, @defaultSymbol = 0) ->

  read: (index) ->
    if index >= 0 then TuringTape.readAbstract(@postape, index)
    else TuringTape.readAbstract(@negtape, Math.abs(index) - 1)

  @readAbstract: (tape, index) ->
    return if index < tape.length then tape[index] else @defaultSymbol

  write: (index, symbol, log = console.log) ->
    if symbol < 0 or symbol >= @symbols
      log("[TuringTape] could not write symbol '#{symbol}' to tape, not within tape's symbol range")
    else
      @writeAbstract((if index >= 0 then @postape else @negtape),
        Math.abs(index - (if index >= 0 then 0 else 1)), parseInt(symbol))

  @writeAbstract: (tape, index, symbol) ->
    tape.push(@defaultSymbol) while tape.length < index
    tape[index] = symbol

module.exports = {TuringTape}

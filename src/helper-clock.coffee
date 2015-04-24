###
  helper-clock.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

class Clock
  counter:      null
  previousTime: null
  presentTime:  null
  disabled:     false

  constructor: () ->
    @counter = new Date
    @previousTime = (@counter.getTime() - 1)/1000.0
    @presentTime  = @counter.getTime()/1000.0

  interval: () ->
    @presentTime - @previousTime

  update: () ->
    @previousTime = @presentTime
    if not @disabled then @presentTime = @counter.getTime()/1000.0

  toggle: () ->
    @disabled = not @disabled

module.exports = {Clock}

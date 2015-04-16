###
  turing-main.coffee
  Fionan Haralddottir
  Spring 2015
  This program is published under the MIT licence
###

{TuringMachine} = require "./turing-machine.coffee"

main = () ->
  a = new TuringMachine({})
  console.log "Making stuff :)"

main()

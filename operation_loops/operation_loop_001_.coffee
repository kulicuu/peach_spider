c = -> console.log.apply console, arguments

path = require 'path'
_ = require 'lodash'

require_uncached = (module) ->
    delete require.cache[require.resolve(module)]
    return require(module)

op_loop_001 = (struct, jQuery) ->
    c ''
    c '-----------------------------------'
    # c 'starting op_loop_001', _.keys(struct), jQuery.length
    nk_card = require_uncached(path.resolve(__dirname, '../cards/nekretnine_001_.coffee'))

    nk_card.fields.price jQuery, struct.item_pages[0].html, (price) ->
        c 'price', price

    nk_card.fields.bedrooms jQuery, struct.item_pages[0].html, (bedrooms)->
        c 'bedrooms', bedrooms




module.exports = {op_loop_001}

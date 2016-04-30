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
    fields = nk_card.fields
    html = struct.item_pages[0].html
    pc = partial_curry_000 = (field) =>
        fields[field] jQuery, html, (val) ->
            c field, val

    pc 'price'

    pc 'bedrooms'

    pc 'id'

    pc 'bathrooms'

    pc 'add_date'




module.exports = {op_loop_001}

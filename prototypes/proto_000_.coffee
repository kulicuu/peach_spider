

c = -> console.log.apply console, arguments
c 'hi'
fs = require 'fs'
jQuery = fs.readFileSync('../../private/jquery.min.js', 'utf-8')
# c 'jQuery', jQuery
card = require '../crawlers/cards/cards_001/f_nekretnine.js'
Bluebird = require 'bluebird'
promisify = Bluebird.promisify
# c 'card', card
ioredis = require 'ioredis'
mongodb = require 'mongodb'
d = ioredis.createClient()
_ = require 'lodash'
uuid = require 'node-uuid'
jsdom = require 'jsdom'
struct = null



f = require('./funcs_000.coffee')
    card: card
    d: d
    jQuery: jQuery

# ff = require('./funcs_001.coffee')
#     d: d
#     jQuery: jQuery

f.test()

# F = Bluebird.promisifyAll f

# build data structure

get_html_002_async = promisify f.get_html_002
fetch_href_000_async = promisify f.fetch_href_000
fetch_inside_hrefs_000_async = promisify f.fetch_inside_hrefs_000
counter = 0

requireUncached = (module) ->
    delete require.cache[require.resolve(module)]
    return require(module)


func_000 = (arq)->
    return arq + "1123s"

# make_ticket_000 = () ->

operation_loop = () ->

    # acquire fresh function parameters with fresh require
    card_test = requireUncached './card_000.coffee'
    c card_test.hello
    cc = crawler_callbacks = requireUncached '../crawlers/cards/cards_001/helpers_000.js'
    c func_000 card_test.hello
    card = requireUncached '../crawlers/cards/cards_001/f_nekretnine.js'

    ff = requireUncached('./funcs_001.coffee')
        d: d
        jQuery: jQuery
    # ff.test card, _.keys(cc)
    # ff.test_001()
    # ff.check_id card, cc, struct
    # ff.check_price card, cc, struct

    html = struct.item_pages[0].html
    # ff.check_at_field card, 'price', html, (err, z)->
    #     c 'zzezezez', z

    # ff.nk_get_rooms card, 'bedrooms', html, (err, z)->
    #     c 'bedrooms', z
    ff.write_html_to_cursor_file html, ->
        c '...written cursor file'

    # ff.get_from_bare_selector card, 'phone', html, (err, z)->
    #     c 'z383', z
    #
    # ff.get_html_at_selector card, 'phone', html, (err, z)->
    #     c 'z9292', z
    #
    #
    # ff.get_html_at_selector card, 'price', html, (err, z)->
    #     c 'z000011', z
    #     v = cc.nekretnine_price z
    #     c 'v', v

    ff.nk_get_bedrooms_001 card, 'bedrooms', html, (err, z)->
        # cc.nk_bedrooms



build_000 = (arq)->
    finch = arguments.callee
    {card, struct, cb, next_href} = arq
    # assume url is search root and populate accordinly all search pages

    # atm just going to build on memory, then later
    # worry about redis caching strategy separately. maybe something tricky with url as key-links, because then won't store the html twice.
    if next_href is null
        cursor_url = card.url
    else
        cursor_url = next_href

    get_html_002_async cursor_url
    .then (html)->
        c "counter: #{counter}"
        counter++
        c 'have html...', _.keys(html).length

        struct.search_pages.push
            url: cursor.url
            html: html

        fetch_href_000_async html
        .then (href)->
            c 'here 4 href ', href
            if (href.length > 0) and (counter < 1)
                next_arq =
                    card: card
                    struct: struct
                    cb: cb
                    next_href: href
                finch next_arq
            else
                c 'size of array', _.size(struct.search_pages)
                # return struct
                cb struct
        .error (err3)->
            c 'err4', err4

    .error (err)->
        cb err

build_001 = (arq)->
    # c 'in 5', arq
    {struct, card, cb} = arq
    c struct.search_pages.length
    c _.isArray struct.search_pages
    rayy = []
    for item, idx in struct.search_pages
        do (item, idx)->
            c 'item idx', typeof(item), idx
            fetch_inside_hrefs_000_async item.html
            .then (hrefs)=>
                for href, idx2 in hrefs
                    do (href, idx2)->
                        get_html_002_async href
                        .then (html)->
                            rayy.push
                                href: href
                                html: html
                            if idx2 is (hrefs.length - 1)
                                struct.item_pages = rayy
                                cb struct
                        .error (err2)->
                            cb err2
            .error (err)->
                c err




build_data_struct = (cb)->
    build_000
        next_href: null
        card: card
        struct:
            search_pages : []
            item_pages: []
        cb: (struct)->
            c 'here 3', _.keys(struct.search_pages).length
            # c 'here 8', struct.search_pages[0].length
            build_001
                struct: struct
                card: card
                cb: (struct)->
                    c 'here 4', _.keys(struct.item_pages).length
                    cb null, struct

module.exports = build_data_struct_a = promisify build_data_struct

build_data_struct_a()
.then (struct)->
    struct = struct
    c "here 8", _.keys(struct).length
    operation_loop()
.error (err)->
    c "8 err", err

main = ->
    # get data from request or cache

    # start operation_loop,
    # we don't need the watcher to be separate, just
    # just restart operation loop


fs = require 'fs'


fs.watch './funcs_001.coffee', {encoding: 'buffer'}, (event, filename) =>
    c 'got one watch event', event, filename
    operation_loop()

fs.watch './card_000.coffee', {encoding: 'buffer'}, (event, filename) =>
    c 'got one watch event', event, filename
    operation_loop()

fs.watch '../crawlers/cards/cards_001/f_nekretnine.js', {encoding: 'buffer'}, (event, filename) =>
    c 'got another watch event', event, filename
    operation_loop()

fs.watch '../crawlers/cards/cards_001/helpers_000.js', {encoding: 'buffer'}, (event, filename) =>
    c '...'
    operation_loop()






# get_html_002_async card.url
# .then (go)->
#     c 'have go...', _.keys(go).length
#     d.quit()
# .error (err)->
#     c 'there was err', err


# f.get_html_002 card.url, (err, go)->
#     c 'have go', _.keys(go).length
#
#
#
#     d.quit()

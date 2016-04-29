

c = -> console.log.apply console, arguments
c 'hi'
fs = require 'fs'
jQuery = fs.readFileSync('../../private/jquery.min.js', 'utf-8')
# c 'jQuery', jQuery

card = require '../crawlers/cards/cards_001/f_nekretnine.js'
# atm i'm thinking the card idea is stupid and silly.  each site will
# need it's own set of scrape functions one for each data point target
# each site will get its own file.
# otoh may want something with the main search url on it avail
# for the data set build function.

Bluebird = require 'bluebird'
promisify = Bluebird.promisify
# c 'card', card
ioredis = require 'ioredis'
# mongodb = require 'mongodb'
d = ioredis.createClient()
_ = require 'lodash'
uuid = require 'node-uuid'
jsdom = require 'jsdom'









require_uncached = (module) ->
    delete require.cache[require.resolve(module)]
    return require(module)


# TODO : check if it's possible to have a require function
# which is ENV variable dependent, so always it uses requireUncached
# if in DEV and always require when in PROD
# this -> attempt:
require2 = (module) ->
    if process.ENV is 'DEV'
        delete require.cache(require.resolve(module))
        return require(module)
    else if process.ENV is 'PROD'
        return require(module)

scrape_href_000 = (html, next_selector, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window) =>
            if err then cb err else
                href = window.$(next_selector).attr('href')
                cb null, href

get_html_002 = (url, cb)->
    d.get url, (err, re) ->
        if err then cb err else
            if re is null
                c 'no cached version; preparing HTTP request'
                request url, (err2, res, body) ->
                    if err2 then cb err2 else
                        d.set url, body
                        cb null, body
            else
                c 'got cached'
                cb null, re # is body

fetch_inside_hrefs_000 = (html, inside_selector, cb)->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window) =>
            if err then cb err else
                $ = window.$
                insides = $(inside_selector)
                hrefs_rayy = _.reduce insides, (acc, item, idx)->
                    acc.push $(item).attr('href')
                    acc
                , []
                cb null, hrefs_rayy


get_html_a = promisify get_html_002
scrape_href_a = promisify scrape_href_000
fetch_inside_hrefs_a = promisify fetch_inside_hrefs_000



cursive_assemble_search_pages_000 = (arq, cb) ->
    go_recurse = arguments.callee
    {next_href, struct, next_selector} = arq

    get_html_a next_href
    .then (html)->
        struct.search_pages.push
            url: next_href
            html: html

        scrape_href_a html
        .then (href)->
            if (href.length > 0) and (counter < 1)
                next_arq =
                    next_href: href
                    struct: struct
                    cb: cb
                    next_selector: next_selector
                go_recurse next_arq
            else
                cb null, struct
        .error (err3)->
            cb err3

assemble_item_pages_000 = (arq)->
    {struct, card, cb} = arq
    item_pages = []
    for item, idx in struct.search_pages
        fetch_inside_hrefs_a item.html
        .then (hrefs_rayy)->
            for href, idx2 in hrefs_rayy
                get_html_a href
                .then (html)->
                    item_pages.push
                        url: href
                        html: html
                    if idx2 is (hrefs_rayy.length - 1)
                        struct.item_pages = item_pages
                        cb null, struct
                .error (err)->
                    cb err
        .then (err)->
            cb err

cursive_assemble_search_pages_a = promisify cursive_assemble_search_pages_000
assemble_item_pages_a = promisify assemble_item_pages_000

assemble_total_site_data_set_000 = (arq, cb)->
    {search_page_start_href, next_selector} = arq
    cursive_assemble_search_pages_a
        next_href: search_page_start_href
        struct:
            search_pages: []
            item_pages: []
        next_selector:
    .then (struct)->










exports.cursive_assemble_data_set_000 = cursive_assemble_data_set_000

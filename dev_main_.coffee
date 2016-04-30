


c = -> console.log.apply console, arguments
chokidar = require 'chokidar'
fs = require 'fs'
# jQuery = fs.readFileSync('./lib/jquery.min.js', 'utf-8')
Bluebird = require 'bluebird'
promisify = Bluebird.promisify
ioredis = require 'ioredis'
# mongodb = require 'mongodb'
d = ioredis.createClient()
_ = require 'lodash'
# uuid = require 'node-uuid'
jsdom = require 'jsdom'
fs = require 'fs'
path = require 'path'
jQuery = fs.readFileSync(path.resolve('./lib/jquery.min.js'), 'utf-8')

# effective global:
struct_glb = {}
# ---------------------- may find a better way / pass it , later

require_uncached = (module) ->
    delete require.cache[require.resolve(module)]
    return require(module)

operation_loop = () ->
    # c '(re)/starting op loop'
    {op_loop_001} = require_uncached(path.resolve('./operation_loops/operation_loop_001_.coffee'))
    # c 'jQuery', jQuery.length
    fs.writeFile path.resolve(__dirname, './html_cursors/cursor.html'), struct_glb.item_pages[0].html, (err)->
        if err then c err
    op_loop_001 struct_glb, jQuery

    # nk_card = require_uncached(path.resolve('./cards/nekretnine_001_.coffee'))
    # price = nk_card.fields.price jQuery, struct_glb.item_pages[0].html
    # c 'price', price

    # {search_page_start_href, next_selector} = arq
    # arq =
    #     search_page_start_href: nk_card.next_page_start_href
    #     next_selector: nk_card.next_selector




watcher_alpha = chokidar.watch(path.resolve('./cards'))
watcher_beta = chokidar.watch(path.resolve('./operation_loops'))
watcher_alpha.on 'change', (pth, stats) ->
    # c 'alpha change'
    operation_loop()
watcher_beta.on 'change', (pth, stats) ->
    # c 'beta change'
    operation_loop()


{assemble_total_site_data_set_000 : assemble_data} = require_uncached('./data_builders/builder_001_.coffee')
assemble_data_a = promisify assemble_data
nk_card = require_uncached(path.resolve('./cards/nekretnine_001_.coffee'))

# {search_page_start_href, next_selector} = arq
arq =
    search_page_start_href: nk_card.search_page_start_href
    next_selector: nk_card.next_selector
    item_selector: nk_card.item_selector

assemble_data arq, (struct) ->
    c '...', _.keys(struct.item_pages).length
    struct_glb = struct
    operation_loop()

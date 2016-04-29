


c = -> console.log.apply console, arguments
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

# effective global:
struct = {}
# ---------------------- may find a better way / pass it , later

require_uncached = (module) ->
    delete require.cache[require.resolve(module)]
    return require(module)

operation_loop = () ->

# fs.watch './cards/*', {encoding: 'buffer'}, (event, filename) ->
#     operation_loop()

# {search_page_start_href, next_selector} = arq

{assemble_total_site_data_set_000 : assemble_data} = require_uncached('./data_builders/builder_001_.coffee')

c 'assemble_data', assemble_data

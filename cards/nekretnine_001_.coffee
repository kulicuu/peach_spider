


c = -> console.log.apply console, arguments
jsdom = require 'jsdom'
_ = require 'lodash'




# --------base card attributes
domain = 'http://www.nekretnine.rs/'
search_page_start_href = 'http://www.nekretnine.rs/stambeni-objekti/stanovi/izdavanje-prodaja/izdavanje/zemlja/srbija/lista/po_stranici/10/'
item_basket = 'div.resultWrap.fixed'
next_selector = 'a.pag_next'
item_selector = 'div.resultInfo.fixed h2.marginB_5 a'
# --------------------------------------------------------


# ------------ main crawler functions by field


bathrooms = (jQuery, html, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window)->
            $ = window.$
            z = $('div.sLeftGrid.fixed li div.singleLabel')
            # c 'z', z
            v = null
            for key, item of z
                if _.isFinite(parseInt(key))
                    w = $(item).html()
                else
                    w = null
                if w is "Kupatila:"
                    v = $(item).next().html()
                    break
            cb v


id = (jQuery, html, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window)->
            $ = window.$
            z = $('div.sLeftGrid.fixed li div.singleLabel')
            # c 'z', z
            v = null
            for key, item of z
                if _.isFinite(parseInt(key))
                    w = $(item).html()
                else
                    w = null
                if w is "ID:"
                    v = $(item).next().html()
                    break
            cb v

bedrooms = (jQuery, html, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window)->
            $ = window.$
            z = $('div.singleLabel')
            v = null
            for key, item of z
                if _.isFinite(parseInt(key))
                    w = $(item).html()
                else
                    w = null
                if w is "Sobe:"
                    v = $(item).next().html()
                    break
            cb v

price = (jQuery, html, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window) ->
            $ = window.$
            str = $('div.advert_info_holder.fixed h3.right').html()
            s0 = str.substr(str.indexOf(',') + 1).trim();
            s1 = s0.split(' ')[0].split(',');
            s4 = _.reduce s1, (acc, item, idx) ->
                acc = acc + item;
                return acc
            , ''
            cb parseInt(s4)



fields = {bedrooms, price, id, bathrooms}

fields_target = [
    'id', 'currency', 'price', 'add_date', 'date', 'bathrooms', 'bedrooms', 'livingrooms',
'size', 'phone', 'pics[0].url', 'pics[1].url', 'pics[2].url', 'pics[3].url', 'pics[4].url', 'pics[5].url', 'pics[6].url', 'pics[7].url', 'pics[8].url', 'pics[9].url'
]

module.exports = {domain, search_page_start_href, item_basket, next_selector, item_selector, fields}

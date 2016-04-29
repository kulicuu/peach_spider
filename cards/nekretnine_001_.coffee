


c = -> console.log.apply console, arguments
jQuery = fs.readFileSync('../lib/jquery.min.js', 'utf-8')



# --------base card attributes
domain = 'http://www.nekretnine.rs/'
url = 'http://www.nekretnine.rs/stambeni-objekti/stanovi/izdavanje-prodaja/izdavanje/zemlja/srbija/lista/po_stranici/10/'
item_basket = 'div.resultWrap.fixed'
next_selector = 'a.pag_next'
item_selector = 'div.resultInfo.fixed h2.marginB_5 a'
# --------------------------------------------------------


# ------------ main crawler functions by field
bedrooms = (html, cb) ->
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
            cb null, v

price = (html, cb) ->
    jsdom.env
        html: html
        src: [jQuery]
        done: (err, window)=>
            $ = window.$
            y = _.find card.rules.item_rules, {field: 'price'}
            c y.selector
            z = $(y.selector).html()
            c 'zeeee', $(z[0])
            helpers.nekretnine_price z




fields = fields_001 = {bedrooms, price}

fields_target = [
    'id', 'currency', 'price', 'add_date', 'date', 'bathrooms', 'bedrooms', 'livingrooms',
'size', 'phone', 'pics[0].url', 'pics[1].url', 'pics[2].url', 'pics[3].url', 'pics[4].url', 'pics[5].url', 'pics[6].url', 'pics[7].url', 'pics[8].url', 'pics[9].url'
]




module.exports = {domain, url, item_basket, next_selector, item_selector, fields}

# scraper bot

We're building a data-grabber/web-scraper using NodeJS.

Caching will be initially with Redis, but also options to put data to MongoDB should be easy to implement.

Coding in CoffeeScript because it's fast (to write & to read) with concise syntax.  (I'd be happy to dev or maintain implementations in any other jS flavour-- contact me)

Focus here is on creating an efficient development environment, in particular for the dev-process of configuring site-specific bots.  We'll cache the html data locally, and reload our scraper data modules hot so we don't need to restart any Node process at all.

Another priority is testing coverage.  We expect sites to evolve and data to mutate quickly; if we expect to serve a client whose enterprise is dependent on the accuracy, timeliness of the data we'll need to be able to run tests at various levels quickly and easily.  

### Quickstart
_development_
- clone and `npm install`
- start a Redis server.
- `coffee dev_main_.coffee` or better yet : `nodemon --watch dev_main_.coffee dev_main_.coffee`

Now when you configure on a card and save, the `operation_loop` function restarts, that module is require fresh uncached.
Also, I'm factoring out the `op_loop` definitions to `uncached_require`d files, so you can tweak those as well without a full process restart.  Full process restart (ideally by nodemon) only required on `dev_main_.coffee` file change, which should be necessary only rarely.

### sections / folders

- **prototypes**: I sketch out ideas in code here, and implement proof-of-concept vehicles. In the beginning of development cycle this is an active folder, then less so as implementation progresses; and again more so if refactoring or feature addition is initiated.

- **test**: Mocha test runners, config stuff.

- **cards**: Originally just held site-specific meta info.  Actually might as well put all the site-specific scraper functions into it as well.  Thus instead of fields as array of strings would have an array of functions to execute, each of which would provide

- **common**: Functions that are used by more than one card can be factored over into files within a common folder

- **html_cursors**: Where to make scraped source html available for manual inspection from within browser, or for e2e testing.  This is important as manually navigating to site pages from within browsers can yield different source html than that acquired by npm's request module-- question of config/header variables.

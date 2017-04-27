(function() {
  'use strict';

  var globals = typeof global === 'undefined' ? self : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = {}.hasOwnProperty;

  var expRe = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (expRe.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var hot = hmr && hmr.createHot(name);
    var module = {id: name, exports: {}, hot: hot};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var expandAlias = function(name) {
    return aliases[name] ? expandAlias(aliases[name]) : name;
  };

  var _resolve = function(name, dep) {
    return expandAlias(expand(dirname(name), dep));
  };

  var require = function(name, loaderPath) {
    if (loaderPath == null) loaderPath = '/';
    var path = expandAlias(name);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    throw new Error("Cannot find module '" + name + "' from '" + loaderPath + "'");
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  var extRe = /\.[^.\/]+$/;
  var indexRe = /\/index(\.[^\/]+)?$/;
  var addExtensions = function(bundle) {
    if (extRe.test(bundle)) {
      var alias = bundle.replace(extRe, '');
      if (!has.call(aliases, alias) || aliases[alias].replace(extRe, '') === alias + '/index') {
        aliases[alias] = bundle;
      }
    }

    if (indexRe.test(bundle)) {
      var iAlias = bundle.replace(indexRe, '');
      if (!has.call(aliases, iAlias)) {
        aliases[iAlias] = bundle;
      }
    }
  };

  require.register = require.define = function(bundle, fn) {
    if (bundle && typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          require.register(key, bundle[key]);
        }
      }
    } else {
      modules[bundle] = fn;
      delete cache[bundle];
      addExtensions(bundle);
    }
  };

  require.list = function() {
    var list = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        list.push(item);
      }
    }
    return list;
  };

  var hmr = globals._hmr && new globals._hmr(_resolve, require, modules, cache);
  require._cache = cache;
  require.hmr = hmr && hmr.wrap;
  require.brunch = true;
  globals.require = require;
})();

(function() {
var global = typeof window === 'undefined' ? this : window;
var __makeRelativeRequire = function(require, mappings, pref) {
  var none = {};
  var tryReq = function(name, pref) {
    var val;
    try {
      val = require(pref + '/node_modules/' + name);
      return val;
    } catch (e) {
      if (e.toString().indexOf('Cannot find module') === -1) {
        throw e;
      }

      if (pref.indexOf('node_modules') !== -1) {
        var s = pref.split('/');
        var i = s.lastIndexOf('node_modules');
        var newPref = s.slice(0, i).join('/');
        return tryReq(name, newPref);
      }
    }
    return none;
  };
  return function(name) {
    if (name in mappings) name = mappings[name];
    if (!name) return;
    if (name[0] !== '.' && pref) {
      var val = tryReq(name, pref);
      if (val !== none) return val;
    }
    return require(name);
  }
};
require.register("themes/podigee/src/js/euro_zone_detector.coffee", function(exports, require, module) {
window.in_euro_zone = function(navigator_language) {
  var countries, country, split_language;
  countries = ['AT', 'BE', 'CY', 'DE', 'EE', 'ES', 'FI', 'FR', 'GR', 'IE', 'IT', 'LU', 'LV', 'MT', 'NL', 'PT', 'SI', 'SK'];
  if (!navigator_language) {
    return false;
  }
  split_language = navigator_language.split('-');
  country = split_language[split_language.length - 1];
  if (!country) {
    return false;
  }
  return countries.indexOf(country.toUpperCase()) !== -1;
};

});

require.register("themes/podigee/src/js/initialize.js", function(exports, require, module) {
'use strict';

require('themes/podigee/src/js/plans');
require('themes/podigee/src/js/euro_zone_detector');

});

require.register("themes/podigee/src/js/plans.coffee", function(exports, require, module) {
$(function() {
  var current_currency, current_frequency, hide_all_currencies, hide_all_frequencies, hide_all_plans, set_dollar, set_euro, show_active_currency, show_active_frequency, show_selected_plans, toggle_currency, toggle_frequency;
  console.log('test');
  current_currency = in_euro_zone(navigator.language) ? 'EUR' : 'USD';
  current_frequency = 'y';
  hide_all_plans = function() {
    return $('.plan.EUR, .plan.USD').not('.free').hide();
  };
  show_selected_plans = function() {
    var combined_selector;
    hide_all_plans();
    combined_selector = $(".plan." + current_currency + "." + current_frequency);
    return combined_selector.show();
  };
  show_selected_plans();
  toggle_currency = function() {
    if (current_currency === 'EUR') {
      current_currency = 'USD';
    } else {
      current_currency = 'EUR';
    }
    return show_selected_plans();
  };
  set_dollar = function() {
    current_currency = 'USD';
    return show_selected_plans();
  };
  set_euro = function() {
    current_currency = 'EUR';
    return show_selected_plans();
  };
  hide_all_currencies = function() {
    return $('.switch-currency').find('.EUR, .USD').hide();
  };
  show_active_currency = function() {
    hide_all_currencies();
    return $(".switch-currency ." + current_currency).show();
  };
  show_active_currency();
  $('.switch-currency').on('click', function() {
    toggle_currency();
    return show_active_currency();
  });
  toggle_frequency = function() {
    if (current_frequency === 'y') {
      current_frequency = 'm';
    } else {
      current_frequency = 'y';
    }
    return show_selected_plans();
  };
  hide_all_frequencies = function() {
    return $('.switch-frequency').find('.y, .m').hide();
  };
  show_active_frequency = function() {
    hide_all_frequencies();
    return $(".switch-frequency ." + current_frequency).show();
  };
  show_active_frequency();
  return $('.switch-frequency').on('click', function() {
    toggle_frequency();
    return show_active_frequency();
  });
});

});

require.register("___globals___", function(exports, require, module) {
  
});})();require('___globals___');


//# sourceMappingURL=app.js.map
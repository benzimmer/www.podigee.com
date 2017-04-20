// See http://brunch.io for documentation.
exports.files = {
  javascripts: {
    joinTo: {
      'js/vendor.js': /^(?!app)/, // Files that are not in `app` dir.
      'js/app.js': /^app/
    }
  },
  stylesheets: {joinTo: '/css/app.css'}
};

exports.plugins = {
  babel: {presets: ['latest']},
  sass: {
    debug: 'comments',
    mode: 'native'
  }
};

exports.paths = {
  public: 'themes/podigee/static',
  watched: ['themes/podigee/src/js', 'themes/podigee/src/css']
};

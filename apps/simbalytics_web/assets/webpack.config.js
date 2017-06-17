const path = require("path");
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const webpack = require('webpack');
const prod = process.argv.indexOf('-p') !== -1;

const config = {
  devtool: 'source-map',
  entry: {
    app: './js/app.js',
    react_app: './js/react_app.js',
    main: './scss/style.scss'
  },
  output: {
    path: path.resolve(__dirname, "../priv/static"),
    filename: 'js/[name].js',
    publicPath: 'http://localhost:8080/'
  },
  plugins: [
    new CopyWebpackPlugin([{
        from: "./static",
        to: path.resolve(__dirname, "../priv/static")
      }]),
    new ExtractTextPlugin('css/[name].css'),
  ],
  module: {
      loaders: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          loader: 'babel-loader'
        },
        {
          test   : /\.css$/,
          loaders: ['style-loader', 'css-loader', 'resolve-url-loader']
        },
        {
          test   : /\.scss$/,
          loader: ExtractTextPlugin.extract({
            fallbackLoader: 'style-loader',
            loader: ['css-loader', 'resolve-url-loader', 'sass-loader?sourceMap']
          })
        },
        { test: /\.(jpe?g|png|gif|svg)$/,
          loader: 'url-loader',
          query: {limit: 10240}
        },
        {
          test: /\.(jpe?g|png|gif|svg)$/,
          use: {
             loader: 'file-loader',
             options: {
                  name: '../images/[hash].[ext]', // check the path
            }
          }
        }
      ],
    },
}



config.plugins = config.plugins||[];
if (prod) {
  config.plugins.push(new webpack.DefinePlugin({
      'process.env': {
          'NODE_ENV': `"production"`
      }
  }));
} else {
  config.plugins.push(new webpack.DefinePlugin({
      'process.env': {
          'NODE_ENV': `""`
      }
  }));
}


module.exports = config;

#!/usr/bin/bash

# Linux BASH Script to manually setup a React project without using create-react-app

# Based on:
# https://blog.bitsrc.io/create-react-app-without-create-react-app-b0a5806a92

if [ -z "$1" ]
  then
    DIRECTORY=$1
fi

if [ -z "$1" ]
then
        DIRECTORY="new_react_app"
else
        DIRECTORY=$1
fi

# 1. Create directory for new application
echo "Creating directory for new app: $DIRECTORY"
mkdir $DIRECTORY; cd $DIRECTORY

# 2. Create .gitignore file
echo "Creating .gitignore"
cat << EOF >> .gitignore
node_modules/
package-lock.json
yarn.lock
EOF

# 3. Create package.json file
echo "Creating package.json"
cat << EOF >> package.json
{
  "name": "new-react-app",
  "version": "1.0.0",
  "description": "A new react app without CRA",
  "main": "index.js",
  "scripts": {
    "start": "webpack-dev-server .",
    "build": "Webpack .",
    "test": "test"
  },
  "author": "",
  "license": "MIT"
}
EOF


# 4. Add webpack and related dependencies
echo "Installing webpack dependencies..."
echo "Webpack is a lightweight bundler and webserver for your React application."
npm i --save-dev webpack webpack-cli webpack-dev-server html-webpack-plugin

# 5. Add Babel and related dependencies
echo "Installing Babel..."
echo "Babel is a JavaScript transpiler that allows you to code in the latest versions of JavaScript, then converts it into a version compatible with a variety of browsers."
npm i --save-dev babel-loader @babel/preset-env @babel/core @babel/plugin-transform-runtime @babel/preset-react @babel/runtime @babel/cli

# 6. Add ESLint and configuration
echo "Installing ESLint server and configuration template (AirBNB ruleset)..."
npm i --save-dev eslint eslint-config-airbnb-base eslint-plugin-jest eslint-config-prettier path

# 7. Add React library and React-DOM
echo "Install React and React-DOM libraries"
npm i react react-dom

# 8. Create public folder for static files
echo "Create a \"public\" and \"src\" folder."
mkdir public
mkdir src

# 9. Creating index.html file inside public folder
echo "Creating index.html"
cat << EOF >> public/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
    <title>React App</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOF

# 10. Write out index.js
echo "Creating index.js"
cat << EOF >> src/index.js
import React from "react";
import reactDOM from "react-dom";
import App from "./App";

reactDOM.render(<App />, document.getElementById("root"));
EOF


# 11. Write out initial App.jsx
echo "Creating a basic \"App.jsx\" file."
cat << EOF >> src/App.jsx
import React from "react";

const App = () =>{
    return (
        <h1>
            This is a React App
        </h1>
    )
}

export default App;
EOF


# 12. Write out webpack.config.js (Webpack configuration file)
echo "Creating webpack config file"
cat << EOF >> webpack.config.js
const path = require("path");
const HtmlWebpackPlugin = require('html-webpack-plugin');

/*We are basically telling webpack to take index.js from entry. Then check for all file extensions in resolve. 
After that apply all the rules in module.rules and produce the output and place it in main.js in the public folder.*/

module.exports={
    /** "mode"
     * the environment - development, production, none. tells webpack 
     * to use its built-in optimizations accordingly. default is production 
     */
    mode: "development", 
    /** "entry"
     * the entry point 
     */
    entry: "./index.js", 
    output: {
        /** "path"
         * the folder path of the output file 
         */
        path: path.resolve(__dirname, "public"),
        /** "filename"
         * the name of the output file 
         */
        filename: "main.js"
    },
    /** "target"
     * setting "node" as target app (server side), and setting it as "web" is 
     * for browser (client side). Default is "web"
     */
    target: "web",
    devServer: {
        /** "port" 
         * port of dev server
        */
        port: "9500",
        /** "static" 
         * This property tells Webpack what static file it should serve
        */
        static: ["./public"],
        /** "open" 
         * opens the browser after server is successfully started
        */
        open: true,
        /** "hot"
         * enabling and disabling HMR. takes "true", "false" and "only". 
         * "only" is used if enable Hot Module Replacement without page 
         * refresh as a fallback in case of build failures
         */
        hot: true ,
        /** "liveReload"
         * disable live reload on the browser. "hot" must be set to false for this to work
        */
        liveReload: true
    },
    resolve: {
        /** "extensions" 
         * If multiple files share the same name but have different extensions, webpack will 
         * resolve the one with the extension listed first in the array and skip the rest. 
         * This is what enables users to leave off the extension when importing
         */
        extensions: ['.js','.jsx','.json'] 
    },
    module:{
        /** "rules"
         * This says - "Hey webpack compiler, when you come across a path that resolves to a '.js or .jsx' 
         * file inside of a require()/import statement, use the babel-loader to transform it before you 
         * add it to the bundle. And in this process, kindly make sure to exclude node_modules folder from 
         * being searched"
         */
        rules: [
            {
                test: /\.(js|jsx)$/,    //kind of file extension this rule should look for and apply in test
                exclude: /node_modules/, //folder to be excluded
                use:  'babel-loader' //loader which we are going to use
            }
        ]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: './public/index.html',
            filename: './index.html',
        }),
    ]
}
EOF

# 13. Create .babelrc (Babel configuration) file
echo "Creating .babelrc"
cat << EOF >> .babelrc
{
    /*
        a preset is a set of plugins used to support particular language features.
        The two presets Babel uses by default: es2015, react
    */
    "presets": [
        "@babel/preset-env", //compiling ES2015+ syntax
        "@babel/preset-react" //for react
    ],
    /*
        Babel's code transformations are enabled by applying plugins (or presets) to your configuration file.
    */
    "plugins": [
        "@babel/plugin-transform-runtime"
    ]
}
EOF

echo "Finished setting up React App."
#!/usr/bin/bash

# Linux BASH Script to manually setup a React project without using create-react-app

# Based on:
# https://blog.bitsrc.io/create-react-app-without-create-react-app-b0a5806a92

echo "Installing webpack dependencies..."
echo "Webpack is a lightweight bundler and webserver for your React application."
npm i --save-dev webpack webpack-cli webpack-dev-server

echo "Installing Babel..."
echo "Babel is a JavaScript transpiler that allows you to code in the latest versions of JavaScript, then converts it into a version compatible with a variety of browsers."
npm i --save-dev babel-loader @babel/preset-env @babel/core
@babel/plugin-transform-runtime
@babel/preset-react
@babel/runtime
@babel/cli

echo "Installing ESLint server and configuration template (AirBNB ruleset)..."
npm i --save-dev eslint eslint-config-airbnb-base
eslint-plugin-jest
eslint-config-prettier
path

echo "Install React and React-DOM libraries"
npm i react react-dom

echo "Create a \"public\" folder, and create an \"index.html\" file inside it."
mkdir public
cd public
touch index.html

echo "Creating a basic \"App.js\" file."
touch App.js

# Write out App.js
cat << EOF >> App.js
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


# Write out index.js
echo "Creating index.js"
cat << EOF >> index.js
import React from "react";
import reactDOM from "react-dom";
import App from "./App";

reactDOM.render(<App />, document.getElementById("root"));
EOF

# Write out webpack.config.js (Webpack configuration file)
echo "Creating webpack config file"
cat << EOF >> webpack.config.js
const path = require("path");

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
    }
}
EOF

# Create .babelrc file
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

# Create package.json file
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
  "license": "ISC",
  "devDependencies": {
    "@babel/core": "^7.17.2",
    "@babel/plugin-transform-runtime": "^7.17.0",
    "@babel/preset-env": "^7.16.11",
    "@babel/preset-react": "^7.16.7",
    "@babel/runtime": "^7.17.2",
    "babel-eslint": "^10.1.0",
    "babel-loader": "^8.2.3",
    "eslint": "^8.9.0",
    "eslint-config-airbnb-base": "^15.0.0",
    "eslint-config-prettier": "^8.3.0",
    "eslint-plugin-jest": "^26.1.0",
    "webpack": "^5.68.0",
    "webpack-cli": "^4.9.2",
    "webpack-dev-server": "^4.7.4"
  },
  "dependencies": {
    "@babel/cli": "^7.17.0",
    "path": "^0.12.7",
    "react": "^17.0.2",
    "react-dom": "^17.0.2"
  }
}
EOF
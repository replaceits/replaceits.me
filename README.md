# replaceits.me
replaceits.me is a personal website for Sidney Williams (me!). You can find my contact information, public accounts, and my resume here. It also acts as a portfolio and showcases my projects.

## Server
The site is currently being run off of a Digital Ocean, Fedora 25, droplet. My domain name and SSL cert were obtained through Namecheap. I currently update the site through the use of `git`. In order to do this I have a bare repository folder that gets pushed to from my local machine and the `post-receive` hook on the remote server runs `make` and `rsync`s the build into the server directory.

## Prerequisites
[`yuicompressor`](https://github.com/yui/yuicompressor)  

[`SCSS`](https://github.com/sass/sass)

## Building
Simply run `make` in the root of this project and it will auto-compile/build/compress/copy the needed files into `./build/replaceits.me/`

## Installation
Make sure you have a LAMP stack and `mv` the contents of the `./build/replaceits.me/` directory to the server root. (For EX. `/var/www/html/` or `/srv/http`)

## Contributing
If you find a bug/error anywhere in the site please feel free to submit an issue. If you have a fix then please submit a pull request as well and I will verify and merge if applicable.  
  
Any and all images should be compressed/minified. I'm currently using [`image_optim`](https://github.com/toy/image_optim) to achieve this.

## Licensing
```
MIT License

Copyright (c) 2017 Sidney Williams

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

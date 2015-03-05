---
layout: post
title: "将jekyll生成的网站部署到github gages上"
description: "jekyll"
category: "markdown"
tags: [jekyll, blog, github, gh-pages]
---

在jekyll博客项目目录执行

    git init
    git add .
    git commit -a -m "my blog"
    git remote add origin https://www.github.com/roaway/jekyll_blog.git
    git push -u origin master

以上命令，将博客项目列入Git管理，并push到github网站托管。push之前，需在github网站新建一个项目仓库，本例仓库名为jekyll_blog.

编辑项目目录中的_config.yml文件, 将baseurl属性值设置为“/jekyll_blog“。

使用markdown语言编辑好日志文件后，保存在_post目录，生产静态网页文件，同时将源文件上传到github仓库master分支。

    git add .
    git commit -a -m "update"
    jekyll b
    git push -u origin master

输出结果保存在_site目录。

切换\_site目录，将\_site目录下的网站文件上传到github网站jekyll_blog仓库中下gh-pages支分中，命令如下:

    cd _site
    git init
    git br gh-pages
    git add .
    git commit -a -m "static content"
    git remote add origin https://www.github.com/roaway/jekyll_blog.git
    git push -u origin gh-pages

这样，就可以通过<https://roaway.github.com/jekyll_blog>访问网站了。

为了简化操作，还可以写一个makefile文件，实现本地化管理后，自动化同步到网站上。

    deploy:
         git add .
         git commit -a -m "update"
         git push -u origin master
         jekyll b
         cd _site
         git add .
         git comit -a -m "update"
         git push -u origin gh-pages
         cd ..
         git checkout master

这样就可以在本地管理日志，然后执行make，同步到网站上。

---
layout: post
title: "jekyll添加第三方评论系统"
comments: true
description: ""
category: "jekyll"
tags: [jekyll]
---

1. Add a variable called comments to the YAML Front Matter and set its value to true. A sample front matter might look like:

> ...
> layout: default
> comments: true
> # other options
> ...

-------------------------------------------------------------------------------

2. In between a % if page.comments % and a % endif % tag, add the Universal Embed Code in the appropriate template where you'd like Disqus to load.

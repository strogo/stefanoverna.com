---
kind: article
title: PJAX
external_link: https://github.com/defunkt/jquery-pjax
created_at: 4/13/2011 15:00
---

> PJAX loads HTML from your server into the current page
without a full reload. It's ajax with real permalinks,
page titles, and a working back button that fully degrades.

Piccola libreria sviluppata dal solito `defunkt`. Viene sfruttata per il nuovo Issue manager di Github (e verrà presto propagata in altre aree del sito). Lato server è particolarmente semplice supportarlo:

    [@language="ruby"]
    def my_page
      if request.headers['X-PJAX']
        render :layout => false
      end
    end
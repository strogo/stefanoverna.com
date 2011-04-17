---
kind: article
created_at: 04/17/2011 12:23
title: Nanoc, questo sito e prodotti derivati vari
---

Per un sito estremamente nerd, ci vuole una piattaforma di pubblicazione estremamente nerd, mi sembra evidente. I miei bisogni erano fondamentalmente:

* Rapidità nella scrittura;
* Sintassi Markdown;
* Possibilità di scrivere sia post "standard" che semplici link verso risorse esterne;
* Codice pulito in uscita (HTML5);
* Supporto per `Compass`, `SASS` e `Slim`;
* Compressione automatica per gli assets Javascript;
* Evitare totalmente qualsiasi problema di mantenimento della piattaforma stessa;

Mi è sembrato naturale dirigermi verso i vari [progetti di generazione statica di siti web  ](http://ruby-toolbox.com/categories/static_website_generation.html). Con questi tools, i post possono essere scritti su semplici file Markdown e backuppati su Github. Non ci sono security holes da gestire, nessun login/logout. Il deploy equivale semplicemente a lanciare un `rsync` remoto.

Fidandomi tendenzialmente del popolo di Github sono andato diretto su [`Jekyll`](https://github.com/mojombo/jekyll/wiki), il pioniere nel campo. Partito con entusiasmo, purtroppo non è andata come speravo: sebbene scritto bene, non è modulare a sufficienza per permettere troppe personalizzazioni. Avrei potuto forkare `Jeckyll` e modificarmelo, ma non desiderando futuri problemi di mantenimento sono andato alla ricerca di alternative.

Alla fine sono approdato su [`Nanoc`](http://nanoc.stoneship.org/), un progetto non così popolare, ma a mio parere decisamente più valido, sicuramente molto più modulare:

* Permette di creare i propri filtri di conversione da file testuale a codice HTML, con possibilità di concatenazione multipla;
* Permette di creare moduli helpers aggiuntivi per rendere più DRY le viste;
* Permette di implementare anche dei [Data Sources alternativi](http://projects.stoneship.org/trac/nanoc/wiki/DataSources): questo vuol dire che i post possono essere salvati su file, ma non necessariamente. E' ad esempio possibile creare post da Twitter, Delicious o LastFM in poche righe di codice.
* Permette di realizzare diverse rappresentazioni dello stesso post (i.e. JSON, XML ed HTML)

Con un'architettura così ben pensata, è stato sufficiente creare un paio di moduli aggiuntivi per arrivare esattamente ai miei bisogni. In particolare, ho scritto:

* Un filtro Nanoc per tradurre i file Slim;
* Un filtro Nanoc per comprimere i file Javascript con YUI;
* Un filtro Nanoc che va in cerca di eventuali indirizzi mail e li encripta;
* Un task Rake per creare rapidamente lo scheletro per nuovi post;

Date un'occhio al codice sorgente del sito per capire di che pulizia è capace Nanoc!

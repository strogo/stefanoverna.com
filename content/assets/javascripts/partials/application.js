---
order: 100
---

$(document).ready(function(){
  jQuery.timeago.settings.strings = {
    suffixAgo: "fa",
    suffixFromNow: "da ora",
    seconds: "meno di un minuto",
    minute: "circa un minuto",
    minutes: "%d minuti",
    hour: "circa un'ora",
    hours: "circa %d ore",
    day: "un giorno",
    days: "%d giorni",
    month: "circa un mese",
    months: "%d mesi",
    year: "circa un anno",
    years: "%d anni"
  };

  $(".tweet").tweetIt({
    header: "Commenta e/o diffondi!",
    typeATweet: "Il tuo commento qui",
    closeButton: "Chiudi il dialog, grazie.",
    emptyConfirm: "Vuoi davvero inviare il tweet senza commenti?",
    youare: "Sei",
    findingLink: "Ricerca del link...",
    notConnected: "Per commentare/rispondere via Twitter, perfavore loggati premendo il tasto Connect.",
    intro: "Partecipa alla discussione inviando un Twitt.",
    signoutLink: "Esci"
  });

  $("*[data-twitter-related-to]").each(function() {
    $this = $(this);
    var url = $this.attr("data-twitter-related-to");
    $.getJSON("http://search.twitter.com/search.json?q=" + url + "&rpp=1500&callback=?", function(data) {
      $.each(data.results, function(i, twitt) {
        $li = $("<li/>").appendTo($this);
        $("<img/>").attr("src", twitt.profile_image_url).appendTo($li);
        $("<span/>").addClass("from").text("@" + twitt.from_user).appendTo($li);
        $("<span/>").addClass("text").html(twitt.text.replace(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i,"<a href='$1'>$1</a>")).appendTo($li);
        $("<a/>").attr("href", "http://www.twitter.com/"+twitt.from_user+"/status/"+twitt.id_str).addClass("created_at").text(jQuery.timeago(twitt.created_at)).appendTo($li);
      });
    });
  });

  $("*[data-remote]").live("click", function() {
    var link = $(this);
    var url = link.attr("data-remote");
    $.get(url, function(data) {
      $('.day-archive:last').after(data);
      link.remove();
    });
    return false;
  });

  $("*[data-mail-local-part]").each(function() {
    $(this).attr("href", "mailto:" + $(this).attr("data-mail-local-part").split("").reverse().join("") + "@" + $(this).attr("data-mail-domain").split("").reverse().join(""));
  });

});
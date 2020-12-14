var latestSuggestions = false;
// Kalder API til at søge efter filmen i OMDB
var omdb_search = function(e) {
  closeList();
  var el = document.getElementById("movie_search");
  if(el.value.trim().length == 0) return;
  var request = new XMLHttpRequest();
  var url = '/search/' + el.value;
  request.open('GET', url, true);
  request.onload = function() {
    if (this.status >= 200 && this.status < 400) {
      var resp = this.response;
      suggest(el, JSON.parse(resp));
    }
  };
  request.send();
};

var populate = function() {
  var picked_movie = latestSuggestions.find(o => o.imdb_id === document.getElementById("movie_omdb_id").value);
  if(document.getElementById("movie_title").value == "") document.getElementById("movie_title").value = picked_movie.title;
  if(document.getElementById("movie_poster").value == "") document.getElementById("movie_poster").value = picked_movie.poster;
};

var suggest = function(el, suggestions) {
  if(suggestions.Response == "False") return;
  latestSuggestions = suggestions;
  var elRes, div, i, s, val = el.value;
  elRes = document.getElementById("suggestion-result");
  suggestions.forEach(function(s) {
      div = document.createElement("DIV");
      div.innerHTML = s.title.replace(new RegExp(val.trim(), "gi"), (match) => "<mark>"+match+"</mark>");
      div.innerHTML += "<input type='hidden' value='" + s.title + "' data-omdb_id='"+ s.imdb_id +"'>";
          div.addEventListener("click", function(e) {
          el.value = this.getElementsByTagName("input")[0].value;
          document.getElementById("movie_omdb_id").value = this.getElementsByTagName("input")[0].dataset.omdb_id;
          closeList();
      });
      elRes.appendChild(div);
  });
}
var closeList = function() {
  document.getElementById("suggestion-result").innerHTML = "";
}
// Workaround fordi DOMContentLoaded ikke virkede i test.
var docReady = function(fn) {
    if (document.readyState === "complete" || document.readyState === "interactive") {
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}
docReady(function() {
  var timer = 0;
  document.getElementById("movie_search").addEventListener("keyup", function() {
    clearTimeout(timer);
    timer = setTimeout(omdb_search, 500);
  });
  //document.addEventListener("click", closeList);
  document.getElementById("populate_from_omdb").addEventListener("click", populate);
});

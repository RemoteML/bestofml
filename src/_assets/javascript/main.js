//= require jquery/dist/jquery.min.js
//= require simple-jekyll-search/dest/simple-jekyll-search.min.js

var sjs = SimpleJekyllSearch({
  searchInput: document.getElementById('search-input'),
  resultsContainer: document.getElementById('results-container'),
  json: '/search.json',
  searchResultTemplate: '<li><a href="{url}">{title}<span class="tag is-white is-pulled-right is-hidden-mobile">{category}</span></a></li>',
})
$(document).keyup(function(e) {
  if (e.keyCode === 27) $("#search-section").hide("fast");   // esc
  if ($("#search-input").val() != ""){
    $("#search-destructions").hide("fast")
  } else {
    $("#search-destructions").show()
  }
});
$(document).click(function(e) {
  if ($("#search-input").val() == "") $("#search-destructions").show()
});
$(document).ready(function() {
  $(".search-hide").click(function(){
    $("#search-section").hide("fast");
  });
  $(".search-show").click(function(e){
    e.preventDefault();
    $("#search-section").toggle("fast");
    $("#results-container").text("")
    $("input:text:visible:first").val("").focus();
  });
});

document.addEventListener('DOMContentLoaded', function () {

  // Get all "navbar-burger" elements
  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target from the "data-target" attribute
        var target = $el.dataset.target;
        var $target = document.getElementById(target);

        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }

});

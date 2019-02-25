---
layout: default
---
{% assign cards = site.data[site.cards.data] | slice: 0, 8 %}
{% include hero-intro.html %}
{% include section-cards.html caption="Recently Added" cards=cards %}

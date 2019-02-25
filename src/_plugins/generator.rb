require "json"

class CardGenerator < Jekyll::Generator

  def generate(site)
    data_file = site.config['cards']['data'] # ex: companies

    complete_info = site
      .data[data_file]
      .map { |name, details| details.merge({'name' => name}) }

    site.data[data_file] = complete_info.reverse

    categories = complete_info
      .group_by { |category| [category[site.config['cards']['group_by']['name']], category[site.config['cards']['group_by']['name']].downcase.gsub(/[^0-9a-zA-Z]/, "-")] }
      .sort_by { |key, _values| key[0] }
      .reduce([]) do |acc, group|
      acc << { data_file => group.last, 'name' => group.first.first, 'path' => group.first.last }
    end

    site.data['categories'] = categories
    categories.each { |category| site.pages << build_category_page(site, category) }

    site.data[site.config['cards']['data']].each do |card|
      site.pages << build_card_page(site, card)
    end

    site.pages << build_search(site)
  end

  def build_search(site)
    json = site.data[site.config['cards']['data']].map do |card|
      {
        'title' => card['name'],
        'category' => card[site.config['cards']['group_by']['name']],
        'url' => card['slug'],
      }
    end
    page = Jekyll::PageWithoutAFile.new(site, site.source, "./", "search.json")
    page.content = json.to_json
    page
  end

  def build_card_page(site, card)
    page_name = card['name'].downcase.gsub(/[^0-9a-zA-Z]/, "-")
    page = Jekyll::PageWithoutAFile.new(site, site.source, site.config['cards']['data'], "#{page_name}.md")
    page.data['layout'] = 'card'
    card['slug'] = "/#{site.config['cards']['data']}/#{page_name}"
    page.data['card'] = card
    comments = site.config['cards']['comments']
    comments = card['comments'] unless card['comments'].nil?
    page.data['comments'] = {
      'id' => page_name,
      'show' => comments
    }
    page
  end

  def build_category_page(site, category)
    data = site.config["cards"]["data"]
    category_name = site.config["cards"]["group_by"]["caption"]
    category_field = site.config["cards"]["group_by"]["name"]
    page = Jekyll::PageWithoutAFile.new(site, site.source, category_name, "#{category['path']}.md")
    page.data[category_field] = category['name']
    page.data[data] = category[data]
    page.data['layout'] = 'cards'
    page
  end
end

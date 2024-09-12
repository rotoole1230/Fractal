import Foundation

struct NewsSources {
    static let sources: [NewsSource] = [
        NewsSource(
            id: "coindesk",
            name: "CoinDesk",
            url: URL(string: "https://www.coindesk.com/tag/solana/")!,
            articleSelector: "article.article-card",
            titleSelector: ".card-title",
            linkSelector: "a.card-title-link",
            descriptionSelector: ".card-desc",
            dateSelector: "time",
            imageSelector: ".card-img img"
        ),
        NewsSource(
            id: "theblock",
            name: "The Block",
            url: URL(string: "https://www.theblock.co/search?query=solana")!,
            articleSelector: ".post-card",
            titleSelector: ".post-card__title",
            linkSelector: "a.post-card__title-link",
            descriptionSelector: ".post-card__description",
            dateSelector: ".post-card__date",
            imageSelector: ".post-card__image img"
        ),
        NewsSource(
            id: "decrypt",
            name: "Decrypt",
            url: URL(string: "https://decrypt.co/search?q=solana")!,
            articleSelector: "article.search-result",
            titleSelector: "h3.heading",
            linkSelector: "a.heading",
            descriptionSelector: "p.excerpt",
            dateSelector: "time",
            imageSelector: ".image img"
        ),
        NewsSource(
            id: "solana-foundation",
            name: "Solana Foundation Blog",
            url: URL(string: "https://solana.com/news")!,
            articleSelector: ".news-card",
            titleSelector: ".news-card__title",
            linkSelector: "a.news-card__link",
            descriptionSelector: ".news-card__description",
            dateSelector: ".news-card__date",
            imageSelector: ".news-card__image img"
        ),
        NewsSource(
            id: "cointelegraph",
            name: "CoinTelegraph",
            url: URL(string: "https://cointelegraph.com/tags/solana")!,
            articleSelector: "article.post-card",
            titleSelector: ".post-card__title",
            linkSelector: "a.post-card__title-link",
            descriptionSelector: ".post-card__text",
            dateSelector: "time.post-card__date",
            imageSelector: ".post-card__figure-wrapper img"
        ),
        NewsSource(
            id: "solana-compass",
            name: "Solana Compass",
            url: URL(string: "https://solanacompass.com/news")!,
            articleSelector: ".news-item",
            titleSelector: ".news-item__title",
            linkSelector: "a.news-item__link",
            descriptionSelector: ".news-item__excerpt",
            dateSelector: ".news-item__date",
            imageSelector: ".news-item__image img"
        )
    ]
}

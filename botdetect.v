// Copyright (c) 2019-2023 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module botdetect

// Substrings identifying a known non-human client. Matched case-insensitively
// anywhere in the User-Agent, so a bare token like 'Applebot' also catches the
// crawler that hides behind a full Safari user agent.
pub const bot_uas = [
	// Search engine crawlers.
	'Googlebot',
	'Google-', // Google-Lens, Google-Read-Aloud, Google-InspectionTool, Google-Extended
	'APIs-Google',
	'Mediapartners-Google',
	'Feedfetcher-Google',
	'Applebot',
	'bingbot',
	'BingPreview',
	'msnbot',
	'DuckDuckBot',
	'DuckAssistBot',
	'YandexBot',
	'Baiduspider',
	'PetalBot',
	'SeznamBot',
	'MojeekBot',
	'yacybot',
	'Sogou web spider',
	'Qwantify',
	'Exabot',
	// AI crawlers and assistants.
	'GPTBot',
	'ChatGPT',
	'OAI-SearchBot',
	'ClaudeBot',
	'Claude-User',
	'Claude-SearchBot',
	'PerplexityBot',
	'Perplexity-User',
	'Amazonbot',
	'Applebot-Extended',
	'meta-externalagent',
	'meta-externalfetcher',
	'Bytespider',
	'YouBot',
	'Diffbot',
	'CCBot',
	'AI2Bot',
	'ImagesiftBot',
	'Timpibot',
	'Reflectionbot',
	// Chat and social link-preview fetchers. These render a card for a human,
	// but they are still a server fetching the page rather than a visit.
	'Slackbot',
	'Twitterbot',
	'TelegramBot',
	'Discordbot',
	'facebookexternalhit',
	'Facebot',
	'WhatsApp/',
	'redditbot',
	'LinkedInBot',
	'Pinterestbot',
	'SkypeUriPreview',
	'vkShare',
	'Iframely',
	'Embedly',
	'SummalyBot',
	'matrix-media-repo',
	'Synapse',
	'Mastodon/',
	'Misskey/',
	'Akkoma',
	'Friendica',
	'HatenaBookmark',
	'Hatena-Favicon',
	'Instapaper',
	'Feedly',
	// SEO, marketing and domain crawlers.
	'AhrefsBot',
	'SemrushBot',
	'MJ12bot',
	'DotBot',
	'BLEXBot',
	'Barkrowler',
	'DataForSeo',
	'SeoKicks',
	'Screaming Frog',
	'AdsTxtCrawlerTP',
	'webprosbot',
	'trendiction',
	'domaincrawler',
	'DomainArrivals',
	'wpbot',
	'ShapBot',
	// Scanners, monitors and uptime checkers.
	'Palo Alto Networks',
	'Netcraft',
	'Censys',
	'Shodan',
	'ZGrab',
	'InternetMeasurement',
	'LeakIX',
	'Stretchoid',
	'BinaryEdge',
	'Expanse',
	'CMS-Checker',
	'DowntimeDetector',
	'WebsiteAlphaProbe',
	'nameserver-checker',
	'FreshpingBot',
	'UptimeRobot',
	'Better Uptime',
	'HetrixTools',
	'updown.io',
	'Pingdom',
	'StatusCake',
	'Site24x7',
	'Zabbix',
	'Nagios',
	'Chrome-Lighthouse',
	'PageSpeed',
	'GTmetrix',
	'W3C_Validator',
	// Generic HTTP clients and scraping frameworks. A real browser never
	// identifies itself with one of these.
	'python-requests',
	'aiohttp',
	'httpx',
	'node-fetch',
	'axios/',
	'Scrapy',
	'Go-http-client',
	'okhttp',
	'Java/',
	'libwww-perl',
	'curl/',
	'Wget/',
	'PostmanRuntime',
	'GuzzleHttp',
	'HeadlessChrome',
	'PhantomJS',
	'Puppeteer',
	'Playwright',
	'Selenium',
	'Nutch',
	'Heritrix',
	'ia_archiver',
	'archive.org_bot',
]

// Lowercased once at startup so matching a request never allocates.
const bot_uas_lower = bot_uas.map(it.to_lower())

// Generic self-identification used by crawlers that are not in the list above.
// 'bot' is only matched as a whole token, so 'Abbott' or a product name that
// merely contains the letters does not trigger a false positive.
const bot_markers = [
	'crawler',
	'crawling',
	'spider',
	'scraper',
	'+http', // the "(+https://example.com/bot)" convention
	'bot/',
	'bot;',
	'bot)',
	'bot ',
	'-bot',
	'_bot',
]

// Names that also occur in human user agents, so they only count as a bot when
// the user agent additionally identifies itself as one.
const bot_uas2 = [
	'pleroma',
]

pub fn ua_is_bot(ua string) bool {
	// Visits recorded before the user-agent column existed have no string to
	// judge, so they stay human rather than silently becoming bot traffic.
	if ua == '' {
		return false
	}
	lower := ua.to_lower()
	for bot in botdetect.bot_uas_lower {
		if lower.contains(bot) {
			return true
		}
	}
	for marker in botdetect.bot_markers {
		if lower.contains(marker) {
			return true
		}
	}
	if lower.ends_with('bot') {
		return true
	}
	for name in botdetect.bot_uas2 {
		if lower.contains(name) && lower.contains('bot') {
			return true
		}
	}
	return false
}

pub const bot_urls = [
	'/admin.php',
	'/login.php?s=Admin/login',
	'/wp-content/plugins/',
	'/wp-admin/',
	'/wp-includes/',
	'/wp_filemanager.php',
	'/wp-includes/wp-class.php',
]

pub fn url_is_requested_by_bot(url string) bool {
	for bot_url in botdetect.bot_urls {
		if url.starts_with(bot_url) {
			return true
		}
	}
	return false
}

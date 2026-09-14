module botdetect

fn test_ua_is_bot_recognizes_blocked_crawlers() {
	assert ua_is_bot('Mozilla/5.0 (compatible; SemrushBot/7~bl; +https://www.semrush.com/bot.html)')
	assert ua_is_bot('Mozilla/5.0 (compatible; MJ12bot/v1.4.8; http://mj12bot.com/)')
	assert ua_is_bot('Mozilla/5.0 (compatible; Reflectionbot/1.0; +https://reflection.ai/bot)')
}

fn test_ua_is_bot_recognizes_crawlers_hiding_behind_browser_user_agents() {
	assert ua_is_bot('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)')
	assert ua_is_bot('Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36')
	assert ua_is_bot('Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)')
	assert ua_is_bot('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 OKX-dolphin-crawler')
}

fn test_ua_is_bot_recognizes_ai_crawlers() {
	assert ua_is_bot('Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot')
	assert ua_is_bot('Claude-User (claude-code/2.1.266; +https://support.anthropic.com/)')
	assert ua_is_bot('Mozilla/5.0 (compatible; PerplexityBot/1.0; +https://perplexity.ai/perplexitybot)')
	assert ua_is_bot('Mozilla/5.0 (compatible; GPTBot/1.2; +https://openai.com/gptbot)')
}

fn test_ua_is_bot_recognizes_link_preview_fetchers() {
	assert ua_is_bot('WhatsApp/2')
	assert ua_is_bot('facebookexternalhit/1.1')
	assert ua_is_bot('Mozilla/5.0 (compatible; Discordbot/2.0; +https://discordapp.com)')
	assert ua_is_bot('matrix-media-repo')
	assert ua_is_bot('Synapse (bot; +https://github.com/matrix-org/synapse)')
	assert ua_is_bot('HatenaBookmark/4.0 (Hatena::Bookmark; Analyzer)')
}

fn test_ua_is_bot_recognizes_plain_http_clients() {
	assert ua_is_bot('curl/8.7.1')
	assert ua_is_bot('python-requests/2.31.0')
	assert ua_is_bot('Python/3.11 aiohttp/3.13.3')
	assert ua_is_bot('Go-http-client/1.1')
	assert ua_is_bot('node-fetch/1.0 (+https://github.com/bitinn/node-fetch)')
	assert ua_is_bot('Scrapy/2.17.0 (+https://scrapy.org)')
}

fn test_ua_is_bot_recognizes_scanners_and_monitors() {
	assert ua_is_bot('Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)')
	assert ua_is_bot('DowntimeDetector/4.0 (+https://downforeveryoneorjustme.com)')
	assert ua_is_bot('nameserver-checker-http-validator/1.0')
	assert ua_is_bot('WebsiteAlphaProbe/1.0')
}

fn test_ua_is_bot_keeps_real_browsers_human() {
	assert !ua_is_bot('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36')
	assert !ua_is_bot('Mozilla/5.0 (X11; Linux x86_64; rv:155.0) Gecko/20100101 Firefox/155.0')
	assert !ua_is_bot('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15')
	assert !ua_is_bot('Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36')
	assert !ua_is_bot('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 YaBrowser/26.8.0.0 Safari/537.36')
}

// In-app browsers are a person tapping a link, unlike the preview fetcher that
// the same app sends ahead of them.
fn test_ua_is_bot_keeps_in_app_browsers_human() {
	assert !ua_is_bot('Mozilla/5.0 (iPhone; CPU iPhone OS 26_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23G90 Twitter for iPhone/12.25')
	assert !ua_is_bot('Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148')
	assert !ua_is_bot('Hydra/27 CFNetwork/3896.100.1.2.1 Darwin/27.0.0')
	assert !ua_is_bot('Dalvik/2.1.0 (Linux; U; Android 9.0; ZTE BA520 Build/MRA58K)')
}

// Visits recorded before the user-agent column existed must stay human.
fn test_ua_is_bot_treats_an_empty_user_agent_as_human() {
	assert !ua_is_bot('')
}

fn test_url_is_requested_by_bot() {
	assert url_is_requested_by_bot('/wp-admin/')
	assert url_is_requested_by_bot('/admin.php')
	assert !url_is_requested_by_bot('/')
	assert !url_is_requested_by_bot('/stats228?day=2026-09-14')
}

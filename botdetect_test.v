module botdetect

fn test_ua_is_bot_recognizes_blocked_crawlers() {
	assert ua_is_bot('Mozilla/5.0 (compatible; SemrushBot/7~bl; +https://www.semrush.com/bot.html)')
	assert ua_is_bot('Mozilla/5.0 (compatible; MJ12bot/v1.4.8; http://mj12bot.com/)')
	assert ua_is_bot('Mozilla/5.0 (compatible; Reflectionbot/1.0; +https://reflection.ai/bot)')
}

// Copyright (c) 2019-2023 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module vweb

const bot_uas = [
	'Googlebot',
	'FreshPing',
	'yacybot',
	'Sogou web spider',
	'Slackbot',
	'Twitterbot',
	'webprosbot',
	'TelegramBot',
	'YouBot',
	'AdsTxtCrawlerTP',
	'AhrefsBot',
	'Palo Alto Networks',
]

pub fn ua_is_bot(ua string) bool {
	for bot in vweb.bot_uas {
		if ua.contains(bot) {
			return true
		}
	}
	return false
}

// Must also have "Bot"
const bot_uas2 = [
	'Pleroma',
]

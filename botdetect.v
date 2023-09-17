// Copyright (c) 2019-2023 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module botdetect

const bot_uas = [
	'Googlebot',
	'FreshpingBot',
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
	for bot in botdetect.bot_uas {
		if ua.contains(bot) {
			return true
		}
	}
	return false
}

const bot_urls = [
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

// Must also have "Bot"
const bot_uas2 = [
	'Pleroma',
]

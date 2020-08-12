
// Making Tridactyl work better

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("privacy.resistFingerprinting.block_mozAddonManager", "true");
user_pref("extensions.webextensions.restrictedDomains", '""');

// Privacy & Local Storage

user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.enabled", false); // Disable newtab page
user_pref("browser.startup.homepage", "about:blank"); // Blank startup
// user_pref("signon.autofillForms", false);
// user_pref("signon.rememberSignons", false); // No passwords
user_pref("startup.homepage_welcome_url", "");

// Search Bar Results
user_pref("browser.search.suggest.enabled", false); // Disable search suggestions
user_pref("browser.search.update", false); // Disable search engine changes
user_pref("browser.urlbar.maxRichResults", 0);
user_pref("browser.urlbar.speculativeConnect.enabled", false); // Disable autocomplete URLs

// Network Configuration
// user_pref("network.cookie.cookieBehavior", 1); // Block 3p cookies
// user_pref("network.dns.disablePrefetch", true); // Disable DNS prefetching
// user_pref("network.http.referer.XOriginPolicy", 1); // Send referer to same eTLD sites [Set to "0" if you experience issues with 2FA logins]
// user_pref("network.predictor.enabled", false); // Disable predictor
// user_pref("network.prefetch-next", false); // Disable link prefetching

// Device Fingerprinting
user_pref("beacon.enabled", false); // Disable beacon
user_pref("dom.battery.enabled", false); // Disable battery status
user_pref("dom.event.clipboardevents.enabled", false); // Disable clipboard events
user_pref("dom.gamepad.enabled", false); // Disable USB devices
user_pref("dom.push.enabled", false); // Disable push notifications
user_pref("dom.serviceWorkers.enabled", false); // Disable service workers
user_pref("dom.webnotifications.enabled", false); // Disable desktop notifications
user_pref("general.useragent.override", "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0"); // Useragent [Masks Ubuntu User-Agent; redundant with RFP; remove if on Windows]
user_pref("geo.enabled", false); // Disable geolocation
user_pref("geo.provider.network.url", "");
user_pref("geo.provider-country.network.url", "");
user_pref("media.navigator.enabled", false); // Disable mic and camera
user_pref("media.peerconnection.enabled", false); // Disable WebRTC
user_pref("media.webspeech.synth.enabled", false); // Disable speech synthesis
// user_pref("privacy.donottrackheader.enabled", true); // Send DNT header
// user_pref("privacy.firstparty.isolate", true); // Restrict data to domain level
// user_pref("privacy.resistFingerprinting", false); // RFP [Enable RFP with "true"]
// user_pref("webgl.disabled", true); // Disable WebGL

// Telemetry & Shield
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false); // Disable shield telemetry
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false); // Disable all technical data
user_pref("datareporting.policy.firstRunURL", "");
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.unified", false); // Disable Fx telemetry

// Miscellaneous
user_pref("browser.urlbar.openViewOnFocus", false); // Disable enlargement
user_pref("browser.urlbar.update1", false); // Disable urlbar
user_pref("browser.urlbar.update1.interventions", false); // Disable urlbar
user_pref("browser.urlbar.update1.searchTips", false); // Disable urlbar
user_pref("browser.autofocus", false); // Disable js focus hijack
user_pref("browser.sessionstore.resume_session_once", true); // Restore tabs after restart

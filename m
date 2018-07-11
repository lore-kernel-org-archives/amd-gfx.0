From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 06/21] Update RandR CRTC state if
 set_mode_major fails in set_desired_modes
Date: Wed, 11 Jul 2018 19:27:51 +0200
Message-ID: <20180711172806.22849-7-michel@daenzer.net>
References: <20180711172806.22849-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180711172806.22849-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXaXRob3V0IHRo
aXMsIFJhbmRSIHdvdWxkIHJlcG9ydCB0aGUgQ1JUQyBhbmQgaXRzIG91dHB1dHMgYXMgZW5hYmxl
ZCwKZXZlbiB0aG91Z2ggdGhleSB3ZXJlIGFjdHVhbGx5IG9mZiBkdWUgdG8gdGhlIGZhaWx1cmUu
CgooQ2hlcnJ5IHBpY2tlZCBmcm9tIGFtZGdwdSBjb21taXQgNGRjZGEwYjQ4ZDYyOTQ0Yzg0MWNk
OTU0MGY0YWQ0YzdhYzhkZWU0NykKClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNo
ZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9kcm1tb2RlX2Rpc3BsYXkuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9k
aXNwbGF5LmMgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKaW5kZXggNjRkYWIzMTZmLi5mYTA1Y2Rh
NDggMTAwNjQ0Ci0tLSBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYworKysgYi9zcmMvZHJtbW9kZV9k
aXNwbGF5LmMKQEAgLTI4MzMsNiArMjgzMyw4IEBAIEJvb2wgZHJtbW9kZV9zZXRfZGVzaXJlZF9t
b2RlcyhTY3JuSW5mb1B0ciBwU2NybiwgZHJtbW9kZV9wdHIgZHJtbW9kZSwKIAkJCX0gZWxzZSB7
CiAJCQkJeGY4NkRydk1zZyhwU2Nybi0+c2NybkluZGV4LCBYX1dBUk5JTkcsCiAJCQkJCSAgICJG
YWlsZWQgdG8gc2V0IG1vZGUgb24gQ1JUQyAlZFxuIiwgYyk7CisJCQkJUlJDcnRjU2V0KGNydGMt
PnJhbmRyX2NydGMsIE5VTEwsIGNydGMtPngsIGNydGMtPnksCisJCQkJCSAgY3J0Yy0+cm90YXRp
b24sIDAsIE5VTEwpOwogCQkJfQogCQl9IGVsc2UgewogCQkJY3J0Yy0+bW9kZSA9IGNydGMtPmRl
c2lyZWRNb2RlOwotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK

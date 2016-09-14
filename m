From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/4] Fix radeon_mode_hotplug crash on multi GPU
 platform.
Date: Wed, 14 Sep 2016 17:14:45 +0900
Message-ID: <20160914081447.7221-2-michel@daenzer.net>
References: <20160914081447.7221-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160914081447.7221-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogUWlhbmcgWXUgPFFpYW5nLll1QGFtZC5jb20+CgpPbiBtdWx0aSBHUFUgcGxhdGZvcm0s
IHNvbWUgc2NyZWVuIGlzIGNyZWF0ZWQgYnkgb3RoZXIgR1BVIEREWC4KClNpZ25lZC1vZmYtYnk6
IFFpYW5nIFl1IDxRaWFuZy5ZdUBhbWQuY29tPgooUG9ydGVkIGZyb20gYW1kZ3B1IGNvbW1pdCA5
NzgyNDI5NzdlNWRjOTA1ZTFkNWE0NmIxYjBkMzRiMzU2YzdhZjI2KQoKU2lnbmVkLW9mZi1ieTog
TWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL2RybW1vZGVf
ZGlzcGxheS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNwbGF5LmMgYi9zcmMvZHJtbW9k
ZV9kaXNwbGF5LmMKaW5kZXggM2FhZTY5YS4uYThkNDM4NiAxMDA2NDQKLS0tIGEvc3JjL2RybW1v
ZGVfZGlzcGxheS5jCisrKyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYwpAQCAtMjY0Nyw3ICsyNjQ3
LDggQEAgcmVzdGFydF9kZXN0cm95OgogCQkJeGY4NkNydGNDb25maWdQdHIgbG9vcF9jb25maWcg
PQogCQkJCVhGODZfQ1JUQ19DT05GSUdfUFRSKGxvb3Bfc2Nybik7CiAKLQkJCWlmIChSQURFT05F
bnRQcml2KGxvb3Bfc2NybikgIT0gcFJBREVPTkVudCkKKwkJCWlmIChzdHJjbXAobG9vcF9zY3Ju
LT5kcml2ZXJOYW1lLCBzY3JuLT5kcml2ZXJOYW1lKSB8fAorCQkJICAgIFJBREVPTkVudFByaXYo
bG9vcF9zY3JuKSAhPSBwUkFERU9ORW50KQogCQkJCWNvbnRpbnVlOwogCiAJCQlmb3IgKGogPSAw
OyAhZm91bmQgJiYgaiA8IGxvb3BfY29uZmlnLT5udW1fb3V0cHV0OyBqKyspIHsKLS0gCjIuOS4z
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

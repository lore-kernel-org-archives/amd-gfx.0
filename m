From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 02/15] glamor: Fix leak of pixmap private when
 replacing BO
Date: Wed, 21 Sep 2016 18:50:41 +0900
Message-ID: <20160921095054.28302-2-michel@daenzer.net>
References: <20160921095054.28302-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160921095054.28302-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpSZXBvcnRlZC1i
eTogUWlhbmcgWXUgPHFpYW5nLnl1QGFtZC5jb20+CihQb3J0ZWQgZnJvbSBhbWRncHUgY29tbWl0
IDM5N2FlZGFmZWU0MzdjMTI1YjhhYzFmZWFmYjFjM2I0NjY4NDJhZWIpCgpTaWduZWQtb2ZmLWJ5
OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvcmFkZW9u
X2dsYW1vci5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX2dsYW1vci5jIGIvc3JjL3JhZGVvbl9n
bGFtb3IuYwppbmRleCA3YTZiZjUzLi5iNjY4NDhmIDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX2ds
YW1vci5jCisrKyBiL3NyYy9yYWRlb25fZ2xhbW9yLmMKQEAgLTMxNCwxMCArMzE0LDkgQEAgcmFk
ZW9uX2dsYW1vcl9zZXRfcGl4bWFwX2JvKERyYXdhYmxlUHRyIGRyYXdhYmxlLCBQaXhtYXBQdHIg
cGl4bWFwKQogCQlGcmVlU2NyYXRjaEdDKGdjKTsKIAl9CiAKLQlyYWRlb25fc2V0X3BpeG1hcF9w
cml2YXRlKHBpeG1hcCwgTlVMTCk7Ci0KIAkvKiBBbmQgcmVkaXJlY3QgdGhlIHBpeG1hcCB0byB0
aGUgbmV3IGJvIChmb3IgM0QpLiAqLwogCWdsYW1vcl9lZ2xfZXhjaGFuZ2VfYnVmZmVycyhvbGQs
IHBpeG1hcCk7CisJcmFkZW9uX3NldF9waXhtYXBfcHJpdmF0ZShwaXhtYXAsIHJhZGVvbl9nZXRf
cGl4bWFwX3ByaXZhdGUob2xkKSk7CiAJcmFkZW9uX3NldF9waXhtYXBfcHJpdmF0ZShvbGQsIHBy
aXYpOwogCiAJc2NyZWVuLT5Nb2RpZnlQaXhtYXBIZWFkZXIob2xkLAotLSAKMi45LjMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

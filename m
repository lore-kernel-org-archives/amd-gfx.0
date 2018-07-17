From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati] glamor: Invalidate cached GEM handle in
 radeon_set_pixmap_bo
Date: Tue, 17 Jul 2018 11:43:46 +0200
Message-ID: <20180717094346.14109-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSBjb250aW51
ZWQgdXNpbmcgdGhlIHN0YWxlIGNhY2hlZCBoYW5kbGUsIGNhdXNpbmcgaXNzdWVzIGUuZy4gd2hl
bgpyZXNpemluZyB0aGUgc2NyZWVuIHZpYSBSYW5kUi4KClJlcG9ydGVkLWJ5OiBpaXZlIG9uIElS
QwpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4K
LS0tCiBzcmMvcmFkZW9uLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL3NyYy9yYWRlb24uaCBiL3NyYy9yYWRlb24uaAppbmRleCA0NTBjNjlhYTgu
LjFhMWVkYjFiYSAxMDA2NDQKLS0tIGEvc3JjL3JhZGVvbi5oCisrKyBiL3NyYy9yYWRlb24uaApA
QCAtNzM1LDYgKzczNSw3IEBAIHN0YXRpYyBpbmxpbmUgQm9vbCByYWRlb25fc2V0X3BpeG1hcF9i
byhQaXhtYXBQdHIgcFBpeCwgc3RydWN0IHJhZGVvbl9idWZmZXIgKmJvCiAJCSAgICByZXR1cm4g
VFJVRTsKIAogCQlyYWRlb25fYnVmZmVyX3VucmVmKCZwcml2LT5ibyk7CisJCXByaXYtPmhhbmRs
ZV92YWxpZCA9IEZBTFNFOwogCSAgICB9CiAKIAkgICAgZHJtbW9kZV9mYl9yZWZlcmVuY2UocFJB
REVPTkVudC0+ZmQsICZwcml2LT5mYiwgTlVMTCk7Ci0tIAoyLjE4LjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

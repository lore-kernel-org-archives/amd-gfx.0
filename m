From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH v2 xf86-video-amdgpu] Bail early from drm_wait_pending_flip if
 there's no pending flip
Date: Wed,  5 Sep 2018 11:20:55 +0200
Message-ID: <20180905092055.8934-1-michel@daenzer.net>
References: <20180829165648.1977-3-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180829165648.1977-3-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpObyBuZWVkIHRv
IHByb2Nlc3MgYW55IGV2ZW50cyBpbiB0aGF0IGNhc2UuCgp2MjoKKiBSZS1jaGVjayBkcm1tb2Rl
X2NydGMtPmZsaXBfcGVuZGluZyBhZnRlciBwcm9jZXNzaW5nIGVhY2ggZXZlbnQKClNpZ25lZC1v
ZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9h
bWRncHVfZHJtX3F1ZXVlLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9hbWRncHVfZHJtX3F1ZXVlLmMgYi9z
cmMvYW1kZ3B1X2RybV9xdWV1ZS5jCmluZGV4IGJhODQxZDFlZi4uMDM1MzU2MjM0IDEwMDY0NAot
LS0gYS9zcmMvYW1kZ3B1X2RybV9xdWV1ZS5jCisrKyBiL3NyYy9hbWRncHVfZHJtX3F1ZXVlLmMK
QEAgLTI4NCw3ICsyODQsOCBAQCB2b2lkIGFtZGdwdV9kcm1fd2FpdF9wZW5kaW5nX2ZsaXAoeGY4
NkNydGNQdHIgY3J0YykKIAogCWRybW1vZGVfY3J0Yy0+d2FpdF9mbGlwX25lc3RpbmdfbGV2ZWwr
KzsKIAotCXdoaWxlICgheG9yZ19saXN0X2lzX2VtcHR5KCZhbWRncHVfZHJtX2ZsaXBfc2lnbmFs
bGVkKSkgeworCXdoaWxlIChkcm1tb2RlX2NydGMtPmZsaXBfcGVuZGluZyAmJgorCSAgICAgICAh
eG9yZ19saXN0X2lzX2VtcHR5KCZhbWRncHVfZHJtX2ZsaXBfc2lnbmFsbGVkKSkgewogCQllID0g
eG9yZ19saXN0X2ZpcnN0X2VudHJ5KCZhbWRncHVfZHJtX2ZsaXBfc2lnbmFsbGVkLAogCQkJCQkg
IHN0cnVjdCBhbWRncHVfZHJtX3F1ZXVlX2VudHJ5LCBsaXN0KTsKIAkJYW1kZ3B1X2RybV9xdWV1
ZV9oYW5kbGVfb25lKGUpOwotLSAKMi4xOS4wLnJjMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

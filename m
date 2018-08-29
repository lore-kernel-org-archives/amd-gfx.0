From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 3/3] Bail early from drm_wait_pending_flip
 if there's no pending flip
Date: Wed, 29 Aug 2018 18:56:48 +0200
Message-ID: <20180829165648.1977-3-michel@daenzer.net>
References: <20180829165648.1977-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180829165648.1977-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
IHByb2Nlc3MgYW55IGV2ZW50cyBpbiB0aGF0IGNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvYW1kZ3B1X2RybV9xdWV1
ZS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9zcmMvYW1kZ3B1X2RybV9xdWV1ZS5jIGIvc3JjL2FtZGdwdV9kcm1fcXVldWUuYwppbmRleCBi
YTg0MWQxZWYuLjYxNzMyYjExYyAxMDA2NDQKLS0tIGEvc3JjL2FtZGdwdV9kcm1fcXVldWUuYwor
KysgYi9zcmMvYW1kZ3B1X2RybV9xdWV1ZS5jCkBAIC0yODQsNiArMjg0LDkgQEAgdm9pZCBhbWRn
cHVfZHJtX3dhaXRfcGVuZGluZ19mbGlwKHhmODZDcnRjUHRyIGNydGMpCiAKIAlkcm1tb2RlX2Ny
dGMtPndhaXRfZmxpcF9uZXN0aW5nX2xldmVsKys7CiAKKwlpZiAoIWRybW1vZGVfY3J0Yy0+Zmxp
cF9wZW5kaW5nKQorCQlyZXR1cm47CisKIAl3aGlsZSAoIXhvcmdfbGlzdF9pc19lbXB0eSgmYW1k
Z3B1X2RybV9mbGlwX3NpZ25hbGxlZCkpIHsKIAkJZSA9IHhvcmdfbGlzdF9maXJzdF9lbnRyeSgm
YW1kZ3B1X2RybV9mbGlwX3NpZ25hbGxlZCwKIAkJCQkJICBzdHJ1Y3QgYW1kZ3B1X2RybV9xdWV1
ZV9lbnRyeSwgbGlzdCk7Ci0tIAoyLjE4LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=

From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati] Don't call radeon_cs_flush_indirect &
 radeon_bo_wait in drmmode_copy_fb
Date: Thu,  2 Mar 2017 16:23:59 +0900
Message-ID: <20170302072359.5152-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpSQURFT05XaW5k
b3dFeHBvc3VyZXNfb25lc2hvdCB0YWtlcyBjYXJlIG9mIGl0LgoKU2lnbmVkLW9mZi1ieTogTWlj
aGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL2RybW1vZGVfZGlz
cGxheS5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYwppbmRleCBh
NzkwNGEzOTYuLmFiMTE1ODNhNiAxMDA2NDQKLS0tIGEvc3JjL2RybW1vZGVfZGlzcGxheS5jCisr
KyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYwpAQCAtNDkwLDkgKzQ5MCw2IEBAIHZvaWQgZHJtbW9k
ZV9jb3B5X2ZiKFNjcm5JbmZvUHRyIHBTY3JuLCBkcm1tb2RlX3B0ciBkcm1tb2RlKQogCiAJRnJl
ZVNjcmF0Y2hHQyhnYyk7CiAKLQlyYWRlb25fY3NfZmx1c2hfaW5kaXJlY3QocFNjcm4pOwotCXJh
ZGVvbl9ib193YWl0KGluZm8tPmZyb250X2JvKTsKLQogCXBTY3JlZW4tPmNhbkRvQkdOb25lUm9v
dCA9IFRSVUU7CiAJZGVzdHJveV9waXhtYXBfZm9yX2ZiY29uKHBTY3JuKTsKIAlyZXR1cm47Ci0t
IAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

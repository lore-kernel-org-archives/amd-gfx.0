From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: don't clean the framebuffer for VF
Date: Mon, 6 Feb 2017 14:24:59 +0800
Message-ID: <1486362299-3961-1-git-send-email-Pixel.Ding@amd.com>
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
Cc: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Ding.Pixel-5C7GfCeVMHo@public.gmane.org

VGhlIFNSSU9WIGhvc3QgZHJpdmVyIGNsZWFucyBmcmFtZWJ1ZmZlciBmb3IgZWFjaCBWRiwgZ3Vl
c3QgZHJpdmVyCm5lZWRuJ3QgdGhpcyBhY3Rpb24gd2hpY2ggY29zdHMgbXVjaCB0aW1lIG9uIHNv
bWUgdmlydHVhbGl6YXRpb24KcGxhdGZvcm0sIG90aGVyd2lzZSBpdCBtaWdodCBnZXQgdGltZW91
dCB0byBpbml0aWFsaXplLgoKU2lnbmVkLW9mZi1ieTogUGl4ZWwgRGluZyA8UGl4ZWwuRGluZ0Bh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jIHwgNCAr
KystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwppbmRleCAxZTczNWM0Li5mMWViNGY1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwpAQCAtMjQyLDcgKzI0Miw5IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1ZmJfY3JlYXRlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpoZWxwZXIs
CiAJLyogc2V0dXAgaGVscGVyICovCiAJcmZiZGV2LT5oZWxwZXIuZmIgPSBmYjsKIAotCW1lbXNl
dF9pbyhhYm8tPmtwdHIsIDB4MCwgYW1kZ3B1X2JvX3NpemUoYWJvKSk7CisJaWYgKCFhbWRncHVf
c3Jpb3ZfdmYoYWRldikpIHsKKwkJbWVtc2V0X2lvKGFiby0+a3B0ciwgMHgwLCBhbWRncHVfYm9f
c2l6ZShhYm8pKTsKKwl9CiAKIAlzdHJjcHkoaW5mby0+Zml4LmlkLCAiYW1kZ3B1ZHJtZmIiKTsK
IAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: fix a logic error in pp_hw_init
Date: Sat, 30 Sep 2017 10:50:19 +0800
Message-ID: <1506739820-28659-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODYwN2U1MWEwZTQxNTNiMzYyNjhlMmJjZjRmZTU5NGMyYmZiZmUyMwpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCmluZGV4IGRmNzBjYzcuLjU4NmNhYjcgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTE2
MywxMiArMTYzLDExIEBAIHN0YXRpYyBpbnQgcHBfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJCX0K
IAkJaWYgKHJldCA9PSBQUF9EUE1fRElTQUJMRUQpCiAJCQlnb3RvIGV4aXQ7CisJCXJldCA9IGh3
bWdyX2h3X2luaXQocHBfaGFuZGxlKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gZXhpdDsKIAl9Ci0K
LQlyZXQgPSBod21ncl9od19pbml0KHBwX2hhbmRsZSk7Ci0JaWYgKHJldCkKLQkJZ290byBleGl0
OwotCXJldHVybiAwOworCXJldHVybiByZXQ7CiBleGl0OgogCXBwX2hhbmRsZS0+cG1fZW4gPSAw
OwogCWNnc19ub3RpZnlfZHBtX2VuYWJsZWQoaHdtZ3ItPmRldmljZSwgZmFsc2UpOwotLSAKMS45
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

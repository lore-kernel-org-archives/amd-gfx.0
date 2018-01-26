From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/12] drm/ttm: Simplify ttm_dma_page_put()
Date: Fri, 26 Jan 2018 13:29:05 -0500
Message-ID: <20180126182911.20761-7-tom.stdenis@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126182911.20761-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMgfCA0ICstLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fcGFnZV9hbGxvY19kbWEuYwppbmRleCA2NDdlYjVmNDBhYjkuLjk2MjgzOGNmYjFhMyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvY19kbWEuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jCkBAIC0zOTAsMTQgKzM5
MCwxMiBAQCBzdGF0aWMgdm9pZCB0dG1fZG1hX3BhZ2VfcHV0KHN0cnVjdCBkbWFfcG9vbCAqcG9v
bCwgc3RydWN0IGRtYV9wYWdlICpkX3BhZ2UpCiB7CiAJc3RydWN0IHBhZ2UgKnBhZ2UgPSBkX3Bh
Z2UtPnA7CiAJdW5zaWduZWQgaSwgbnVtX3BhZ2VzOwotCWludCByZXQ7CiAKIAkvKiBEb24ndCBz
ZXQgV0Igb24gV0IgcGFnZSBwb29sLiAqLwogCWlmICghKHBvb2wtPnR5cGUgJiBJU19DQUNIRUQp
KSB7CiAJCW51bV9wYWdlcyA9IHBvb2wtPnNpemUgLyBQQUdFX1NJWkU7CiAJCWZvciAoaSA9IDA7
IGkgPCBudW1fcGFnZXM7ICsraSwgKytwYWdlKSB7Ci0JCQlyZXQgPSBzZXRfcGFnZXNfYXJyYXlf
d2IoJnBhZ2UsIDEpOwotCQkJaWYgKHJldCkgeworCQkJaWYgKHNldF9wYWdlc19hcnJheV93Yigm
cGFnZSwgMSkpIHsKIAkJCQlwcl9lcnIoIiVzOiBGYWlsZWQgdG8gc2V0ICVkIHBhZ2VzIHRvIHdi
IVxuIiwKIAkJCQkgICAgICAgcG9vbC0+ZGV2X25hbWUsIDEpOwogCQkJfQotLSAKMi4xNC4zCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/ttm: Fix trace include path
Date: Fri,  1 Sep 2017 12:10:43 -0400
Message-ID: <20170901161043.6383-2-tom.stdenis@amd.com>
References: <20170901161043.6383-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170901161043.6383-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS90dG0vdHRtX3RyYWNlLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHJhY2UuaAppbmRleCAy
MzI3OWI5YjhlNjQuLjcxNWNlNjhiN2IzMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fdHJhY2UuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90cmFjZS5oCkBAIC04
Miw2ICs4Miw2IEBAIFRSQUNFX0VWRU5UKHR0bV9kbWFfdW5tYXAsCiAKIC8qIFRoaXMgcGFydCBt
dXN0IGJlIG91dHNpZGUgcHJvdGVjdGlvbiAqLwogI3VuZGVmIFRSQUNFX0lOQ0xVREVfUEFUSAot
I2RlZmluZSBUUkFDRV9JTkNMVURFX1BBVEggLgorI2RlZmluZSBUUkFDRV9JTkNMVURFX1BBVEgg
Li4vLi4vZHJpdmVycy9ncHUvZHJtL3R0bS8KICNpbmNsdWRlIDx0cmFjZS9kZWZpbmVfdHJhY2Uu
aD4KIAotLSAKMi4xMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

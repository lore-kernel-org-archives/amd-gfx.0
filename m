From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/14] drm/amd/amdgpu: Tidy up gfx_v9_0_rlc_stop()
Date: Thu, 31 Aug 2017 12:06:43 -0400
Message-ID: <20170831160645.8754-13-tom.stdenis@amd.com>
References: <20170831160645.8754-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831160645.8754-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA3ICstLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwppbmRleCBjNDVjNjljNDY3M2IuLmJmNDI0NWE0MzVhZSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0xOTYxLDEzICsxOTYxLDggQEAgc3Rh
dGljIHZvaWQgZ2Z4X3Y5XzBfaW5pdF9wZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAog
dm9pZCBnZnhfdjlfMF9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKLQl1
MzIgdG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DTlRMKTsKLQotCXRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBSTENfQ05UTCwgUkxDX0VOQUJMRV9GMzIsIDApOwotCVdSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfQ05UTCwgdG1wKTsKLQorCVdSRUczMl9GSUVMRDE1KEdDLCAwLCBSTENf
Q05UTCwgUkxDX0VOQUJMRV9GMzIsIDApOwogCWdmeF92OV8wX2VuYWJsZV9ndWlfaWRsZV9pbnRl
cnJ1cHQoYWRldiwgZmFsc2UpOwotCiAJZ2Z4X3Y5XzBfd2FpdF9mb3JfcmxjX3NlcmRlcyhhZGV2
KTsKIH0KIAotLSAKMi4xMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK

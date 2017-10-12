From: <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: correct reference clock value on vega10
Date: Thu, 12 Oct 2017 10:40:36 +0800
Message-ID: <1507776036-20726-1-git-send-email-Ken.Wang@amd.com>
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
Cc: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VuIFdhbmcgPEtlbi5XYW5nQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzNzcwMjkwNzVh
ZjFlMmUwMDJmN2NmZDc5M2RkZDU4ZDg2MTBlNDc0ClNpZ25lZC1vZmYtYnk6IEtlbiBXYW5nIDxL
ZW4uV2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMg
fCA1ICstLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggNzgzOTY3Ny4uODhkNTQ5OCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC0yNzksMTAgKzI3OSw3IEBAIHN0YXRpYyB2
b2lkIHNvYzE1X2luaXRfZ29sZGVuX3JlZ2lzdGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIH0KIHN0YXRpYyB1MzIgc29jMTVfZ2V0X3hjbGsoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiB7Ci0JaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0ExMCkKLQkJcmV0dXJuIGFk
ZXYtPmNsb2NrLnNwbGwucmVmZXJlbmNlX2ZyZXEvNDsKLQllbHNlCi0JCXJldHVybiBhZGV2LT5j
bG9jay5zcGxsLnJlZmVyZW5jZV9mcmVxOworCXJldHVybiBhZGV2LT5jbG9jay5zcGxsLnJlZmVy
ZW5jZV9mcmVxOwogfQogCiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK

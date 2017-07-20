From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix the incorrect scratch reg number on gfx v9
Date: Thu, 20 Jul 2017 10:21:16 +0800
Message-ID: <1500517276-13243-1-git-send-email-ray.huang@amd.com>
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
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

VGhlcmUgYXJlIDggc2NyYXRjaCByZWdpc3RlcnMgb24gZ2Z4IHY5IChzY3JhY2hfcmVnMCAtPiBz
Y3JhdGNoX3JlZzcpLgoKU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggNDhiNDNlYS4uNGQ3ZjA0MiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0yMTEsNyArMjExLDcgQEAgc3RhdGljIHZvaWQg
Z2Z4X3Y5XzBfaW5pdF9nb2xkZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCiBzdGF0aWMgdm9pZCBnZnhfdjlfMF9zY3JhdGNoX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiB7Ci0JYWRldi0+Z2Z4LnNjcmF0Y2gubnVtX3JlZyA9IDc7CisJYWRldi0+Z2Z4
LnNjcmF0Y2gubnVtX3JlZyA9IDg7CiAJYWRldi0+Z2Z4LnNjcmF0Y2gucmVnX2Jhc2UgPSBTT0Mx
NV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVNDUkFUQ0hfUkVHMCk7CiAJYWRldi0+Z2Z4LnNjcmF0Y2gu
ZnJlZV9tYXNrID0gKDF1IDw8IGFkZXYtPmdmeC5zY3JhdGNoLm51bV9yZWcpIC0gMTsKIH0KLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

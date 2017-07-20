From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: fix the incorrect scratch reg number on gfx v8
Date: Thu, 20 Jul 2017 15:36:11 +0800
Message-ID: <1500536173-19621-1-git-send-email-ray.huang@amd.com>
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

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMKaW5kZXggMTgxZWJhNS4uYjU4ZDk4ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjhfMC5jCkBAIC03NTAsNyArNzUwLDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfaW5pdF9n
b2xkZW5fcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiBzdGF0aWMgdm9p
ZCBnZnhfdjhfMF9zY3JhdGNoX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0J
YWRldi0+Z2Z4LnNjcmF0Y2gubnVtX3JlZyA9IDc7CisJYWRldi0+Z2Z4LnNjcmF0Y2gubnVtX3Jl
ZyA9IDg7CiAJYWRldi0+Z2Z4LnNjcmF0Y2gucmVnX2Jhc2UgPSBtbVNDUkFUQ0hfUkVHMDsKIAlh
ZGV2LT5nZnguc2NyYXRjaC5mcmVlX21hc2sgPSAoMXUgPDwgYWRldi0+Z2Z4LnNjcmF0Y2gubnVt
X3JlZykgLSAxOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=

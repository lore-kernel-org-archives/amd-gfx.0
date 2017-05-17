From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 15:38:48 +0800
Message-ID: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeGh1Yl92MV8wLmMKaW5kZXggMDA1MDc1Zi4uNDEzMTM1MTQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwpAQCAtMzY4LDcgKzM2OCw3IEBAIHN0YXRpYyBpbnQg
Z2Z4aHViX3YxXzBfc3VzcGVuZCh2b2lkICpoYW5kbGUpCiAKIHN0YXRpYyBpbnQgZ2Z4aHViX3Yx
XzBfcmVzdW1lKHZvaWQgKmhhbmRsZSkKIHsKLQlyZXR1cm4gMDsKKwlyZXR1cm4gZ2Z4aHViX3Yx
XzBfaHdfaW5pdChoYW5kbGUpOwogfQogCiBzdGF0aWMgYm9vbCBnZnhodWJfdjFfMF9pc19pZGxl
KHZvaWQgKmhhbmRsZSkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK

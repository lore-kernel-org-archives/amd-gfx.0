From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: return error when sriov access requests get
 timeout
Date: Tue, 31 Oct 2017 15:10:54 +0800
Message-ID: <1509433855-21354-1-git-send-email-Pixel.Ding@amd.com>
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
Cc: pding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>

RnJvbTogcGRpbmcgPFBpeGVsLkRpbmdAYW1kLmNvbT4KClJlcG9ydGVkLWJ5OiBTdW4gR2FyeSA8
R2FyeS5TdW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogcGRpbmcgPFBpeGVsLkRpbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L214Z3B1X3ZpLmMKaW5kZXggODE4ZWMwZi4uZjI5MWZiMiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9teGdwdV92aS5jCkBAIC00NTAsNyArNDUwLDcgQEAgc3RhdGljIGludCB4
Z3B1X3ZpX3NlbmRfYWNjZXNzX3JlcXVlc3RzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CQkJcHJfZXJyKCJEb2Vzbid0IGdldCBhY2sgZnJvbSBwZiwgY29udGludWVcbiIpOwogCX0KIAot
CXJldHVybiAwOworCXJldHVybiByOwogfQogCiBzdGF0aWMgaW50IHhncHVfdmlfcmVxdWVzdF9y
ZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLS0gCjIuOS41CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

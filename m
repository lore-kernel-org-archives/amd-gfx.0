From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: retry init if exclusive mode request is failed
Date: Tue, 31 Oct 2017 15:10:55 +0800
Message-ID: <1509433855-21354-2-git-send-email-Pixel.Ding@amd.com>
References: <1509433855-21354-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509433855-21354-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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

RnJvbTogcGRpbmcgPFBpeGVsLkRpbmdAYW1kLmNvbT4KClRoaXMgaXMgY2F1c2VkIG9mIHRoYXQg
aHlwZXJ2aXNvciBmYWlscyB0byBoYW5kbGUgcmVxdWVzdCwgb25lIGtub3duCmlzc3VlIGlzIE1N
SU8gdW5ibG9ja2luZyB0aW1lb3V0LiBJbiB0aGVvcnkgd2UgY2FuIHJldHJ5IGluaXQgaGVyZS4K
ClNpZ25lZC1vZmYtYnk6IHBkaW5nIDxQaXhlbC5EaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGRhYTIwOTguLmVmMDFhYTMgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTE2MjUsNyArMTYyNSw3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
aWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewogCQlyID0gYW1kZ3B1X3ZpcnRfcmVxdWVzdF9m
dWxsX2dwdShhZGV2LCB0cnVlKTsKIAkJaWYgKHIpCi0JCQlyZXR1cm4gcjsKKwkJCXJldHVybiAt
RUFHQUlOOwogCX0KIAogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tzOyBpKysp
IHsKLS0gCjIuOS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

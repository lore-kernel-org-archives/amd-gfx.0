From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu/soc15: drop dead function
Date: Tue, 11 Jul 2017 19:00:09 -0400
Message-ID: <1499814009-28657-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

TWF5YmUgYSBsZWZ0b3ZlciBmcm9tIGJyaW5ndXA/CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYyB8IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggZGQ1OGRlOS4uOWRmZjI5NCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC01NzgsMTMgKzU3OCw2IEBAIHN0YXRpYyB1
aW50MzJfdCBzb2MxNV9nZXRfcmV2X2lkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQly
ZXR1cm4gbmJpb192Nl8xX2dldF9yZXZfaWQoYWRldik7CiB9CiAKLQotaW50IGdtY192OV8wX21j
X3dhaXRfZm9yX2lkbGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCi17Ci0JLyogdG8gYmUg
aW1wbGVtZW50ZWQgaW4gTUMgSVAqLwotCXJldHVybiAwOwotfQotCiBzdGF0aWMgdm9pZCBzb2Mx
NV9mbHVzaF9oZHAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaWYgKGFkZXYtPmZs
YWdzICYgQU1EX0lTX0FQVSkKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK

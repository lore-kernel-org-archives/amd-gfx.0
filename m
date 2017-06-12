From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: Optimization of mutex usage
Date: Mon, 12 Jun 2017 16:31:24 -0400
Message-ID: <1497299485-7337-3-git-send-email-AlexBin.Xie@amd.com>
References: <1497299485-7337-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1497299485-7337-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

VGhlcmUgaXMgbm8gbmVlZCB0byBsb2NrIHRoZSBib19saXN0IG11dGV4LApiZWNhdXNlIHRoZXJl
IGlzIG5vIG90aGVyIHRhc2sgY2FuIGFjY2Vzcwp0aGUgbmV3bHkgY3JlYXRlZCBCTyBsaXN0IHll
dC4KClNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxBbGV4QmluLlhpZUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMgfCAzIC0tLQogMSBmaWxl
IGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9ib19saXN0LmMKaW5kZXggYzk5NGEwNC4uNDM2M2YyOCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jCkBAIC02MCw4ICs2MCw2IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2JvX2xpc3RfY3JlYXRlKHN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2LAogCSgq
cmVzdWx0KS0+bnVtX2VudHJpZXMgPSAwOwogCSgqcmVzdWx0KS0+YXJyYXkgPSBOVUxMOwogCi0J
bXV0ZXhfbG9jaygmKCpyZXN1bHQpLT5sb2NrKTsKLQogCXJldHVybiAwOwogfQogCkBAIC0yODIs
NyArMjgwLDYgQEAgaW50IGFtZGdwdV9ib19saXN0X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEsCiAKIAkJciA9IGFtZGdwdV9ib19saXN0X3NldChhZGV2LCBmaWxwLCBs
aXN0LCBpbmZvLAogCQkJCQkgICAgICBhcmdzLT5pbi5ib19udW1iZXIpOwotCQlhbWRncHVfYm9f
bGlzdF9wdXQobGlzdCk7CiAJCWlmIChyKQogCQkJZ290byBlcnJvcl9mcmVlOwogCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: "Vishwakarma, Pratik" <Pratik.Vishwakarma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/display: fix compiler errors
 [-Werror,-Wparentheses-equality]
Date: Mon, 4 Feb 2019 08:16:08 +0000
Message-ID: <20190204081546.24935-1-Pratik.Vishwakarma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

UmVtb3ZlIGV4dHJhbmVvdXMgcGFyZW50aGVzZXMgYXJvdW5kIHRoZSBjb21wYXJpc29uCnRvIHNp
bGVuY2UgdGhpcyB3YXJuaW5nCgpTaWduZWQtb2ZmLWJ5OiBQcmF0aWsgVmlzaHdha2FybWEgPFBy
YXRpay5WaXNod2FrYXJtYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jYWxjcy9kY25fY2FsY19hdXRvLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNfYXV0by5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjX2F1dG8uYwppbmRleCA3ZDEwMmFjMGQ2MWIuLjFlZjAw
NzQzMDJjNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNz
L2Rjbl9jYWxjX2F1dG8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2Fs
Y3MvZGNuX2NhbGNfYXV0by5jCkBAIC02Myw3ICs2Myw3IEBAIHZvaWQgc2NhbGVyX3NldHRpbmdz
X2NhbGN1bGF0aW9uKHN0cnVjdCBkY25fYndfaW50ZXJuYWxfdmFycyAqdikKIAkJaWYgKHYtPmlu
dGVybGFjZV9vdXRwdXRba10gPT0gMS4wKSB7CiAJCQl2LT52X3JhdGlvW2tdID0gMi4wICogdi0+
dl9yYXRpb1trXTsKIAkJfQotCQlpZiAoKHYtPnVuZGVyc2Nhbl9vdXRwdXRba10gPT0gMS4wKSkg
eworCQlpZiAodi0+dW5kZXJzY2FuX291dHB1dFtrXSA9PSAxLjApIHsKIAkJCXYtPmhfcmF0aW9b
a10gPSB2LT5oX3JhdGlvW2tdICogdi0+dW5kZXJfc2Nhbl9mYWN0b3I7CiAJCQl2LT52X3JhdGlv
W2tdID0gdi0+dl9yYXRpb1trXSAqIHYtPnVuZGVyX3NjYW5fZmFjdG9yOwogCQl9Ci0tIAoyLjE3
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

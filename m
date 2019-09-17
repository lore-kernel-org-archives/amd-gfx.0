From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: use GPU PAGE SHIFT for umc retired page
Date: Tue, 17 Sep 2019 06:22:28 +0000
Message-ID: <20190917062213.29480-1-tao.zhou1@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Chen,
 Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>

dW1jIHJldGlyZWQgcGFnZSBiZWxvbmdzIHRvIHZyYW0gYW5kIGl0IHNob3VsZCBiZSBhbGlnbmVk
IHRvIGdwdSBwYWdlCnNpemUKClNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKaW5kZXggMWMwZGEzMmMxNTYxLi40N2M0Yjk2YjE0ZDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwpAQCAtMjEzLDcgKzIxMyw3IEBA
IHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAJCQkJPT0gMSkgewogCQkJZXJyX3JlYy0+YWRkcmVzcyA9IGVycl9hZGRy
OwogCQkJLyogcGFnZSBmcmFtZSBhZGRyZXNzIGlzIHNhdmVkICovCi0JCQllcnJfcmVjLT5yZXRp
cmVkX3BhZ2UgPSByZXRpcmVkX3BhZ2UgPj4gUEFHRV9TSElGVDsKKwkJCWVycl9yZWMtPnJldGly
ZWRfcGFnZSA9IHJldGlyZWRfcGFnZSA+PiBBTURHUFVfR1BVX1BBR0VfU0hJRlQ7CiAJCQllcnJf
cmVjLT50cyA9ICh1aW50NjRfdClrdGltZV9nZXRfcmVhbF9zZWNvbmRzKCk7CiAJCQllcnJfcmVj
LT5lcnJfdHlwZSA9IEFNREdQVV9SQVNfRUVQUk9NX0VSUl9OT05fUkVDT1ZFUkFCTEU7CiAJCQll
cnJfcmVjLT5jdSA9IDA7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==

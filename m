From: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: avoid null pointer dereference
Date: Wed, 18 Sep 2019 03:37:47 +0000
Message-ID: <20190918033721.19070-1-guchun.chen@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

bnVsbCBwdHIgc2hvdWxkIGJlIGNoZWNrZWQgZmlyc3QgdG8gYXZvaWQgbnVsbCBwdHIgYWNjZXNz
CgpDaGFuZ2UtSWQ6IEk4NWMwYTA5NmVlZjc3Y2FkM2EzNDI2NWM5OTViMTg0NTQ1MWUwNGQwClNp
Z25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggMDkwZGFmNTk1NDY5Li5jMzA5MGYwZWI2MDQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTEzMzQsMTMgKzEzMzQsMTMg
QEAgc3RhdGljIGludCBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogewogCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9j
b250ZXh0KGFkZXYpOwogCXN0cnVjdCByYXNfZXJyX2hhbmRsZXJfZGF0YSAqZGF0YTsKLQlzdHJ1
Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCA9Ci0JCQkJCSZhZGV2LT5wc3Au
cmFzLnJhcy0+ZWVwcm9tX2NvbnRyb2w7CisJc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRy
b2wgKmNvbnRyb2w7CiAJaW50IHNhdmVfY291bnQ7CiAKIAlpZiAoIWNvbiB8fCAhY29uLT5laF9k
YXRhKQogCQlyZXR1cm4gMDsKIAorCWNvbnRyb2wgPSAmYWRldi0+cHNwLnJhcy5yYXMtPmVlcHJv
bV9jb250cm9sOwogCWRhdGEgPSBjb24tPmVoX2RhdGE7CiAJc2F2ZV9jb3VudCA9IGRhdGEtPmNv
dW50IC0gY29udHJvbC0+bnVtX3JlY3M7CiAJLyogb25seSBuZXcgZW50cmllcyBhcmUgc2F2ZWQg
Ki8KLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

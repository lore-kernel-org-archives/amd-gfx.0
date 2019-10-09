From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet for
 pipe sync
Date: Wed, 9 Oct 2019 17:09:48 +0000
Message-ID: <20191009170923.15479-1-xiaojie.yuan@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

c2RtYSB3aWxsIGhhbmcgb25jZSBzZXF1ZW5jZSBudW1iZXIgdG8gYmUgcG9sbGVkIHJlYWNoZXMg
MHgxMDAwXzAwMDAKClNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCmluZGV4IGFkNWMzNTY2MzM3Yy4uMzQ2MGMwMGYz
ZWFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwpAQCAtMTEyNiw3ICsx
MTI2LDcgQEAgc3RhdGljIHZvaWQgc2RtYV92NV8wX3JpbmdfZW1pdF9waXBlbGluZV9zeW5jKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCBhZGRyICYg
MHhmZmZmZmZmYyk7CiAJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgdXBwZXJfMzJfYml0cyhhZGRy
KSAmIDB4ZmZmZmZmZmYpOwogCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIHNlcSk7IC8qIHJlZmVy
ZW5jZSAqLwotCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDB4ZmZmZmZmZik7IC8qIG1hc2sgKi8K
KwlhbWRncHVfcmluZ193cml0ZShyaW5nLCAweGZmZmZmZmZmKTsgLyogbWFzayAqLwogCWFtZGdw
dV9yaW5nX3dyaXRlKHJpbmcsIFNETUFfUEtUX1BPTExfUkVHTUVNX0RXNV9SRVRSWV9DT1VOVCgw
eGZmZikgfAogCQkJICBTRE1BX1BLVF9QT0xMX1JFR01FTV9EVzVfSU5URVJWQUwoNCkpOyAvKiBy
ZXRyeSBjb3VudCwgcG9sbCBpbnRlcnZhbCAqLwogfQotLSAKMi4yMC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

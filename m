From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] =?UTF-8?q?drm/amdgpu:=20fix=20unused=20variable=20?=
 =?UTF-8?q?=E2=80=98rq=E2=80=99?=
Date: Tue, 7 Aug 2018 16:47:45 +0800
Message-ID: <1533631665-24945-1-git-send-email-ray.huang@amd.com>
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

VGhpcyBwYXRjaCBpcyB0byBmaXggdGhlIHdhcm5pbmcgdG8gcmVtb3ZlIHVudXNlZCB2YXJpYWJs
ZS4KCi9ob21lL3JheS9saW51eC9kcml2ZXJzL2dwdS9kcm0vL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jOgpJbiBmdW5jdGlvbiDigJhhbWRncHVfY3R4X3ByaW9yaXR5X292ZXJyaWRl4oCZOgovaG9t
ZS9yYXkvbGludXgvZHJpdmVycy9ncHUvZHJtLy9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYzozOTc6
MjM6Cndhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhyceKAmSBbLVd1bnVzZWQtdmFyaWFibGVd
CiAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnE7CiAgICAgICAgICAgICAgICAgICAgICAgXgoKU2ln
bmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IDlm
Y2MxNGUuLjAyZDU2M2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMK
QEAgLTM5NCw3ICszOTQsNiBAQCB2b2lkIGFtZGdwdV9jdHhfcHJpb3JpdHlfb3ZlcnJpZGUoc3Ry
dWN0IGFtZGdwdV9jdHggKmN0eCwKIHsKIAlpbnQgaTsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGN0eC0+YWRldjsKLQlzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycTsKIAlzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0eSAqZW50aXR5OwogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsKIAllbnVt
IGRybV9zY2hlZF9wcmlvcml0eSBjdHhfcHJpbzsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

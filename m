From: "Kim, Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] Revert "drm/amdgpu: fix compiler warnings for df perfmons"
Date: Fri, 18 Oct 2019 17:30:30 +0000
Message-ID: <20191018172934.24716-1-jonathan.kim@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Kim,
 Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCA3ZGQyZWIzMWZjZDU2NDU3NGU4ZWZlYTZiZjIzY2Y1MDRmOWUy
ZmQ3LgoKU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZGZfdjNfNi5jCmluZGV4IGUxY2Y3ZTljNjE2YS4uZjQwM2M2MmM5NDRlIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jCkBAIC05Myw3ICs5Myw3IEBAIGNvbnN0IHN0
cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmRmX3YzXzZfYXR0cl9ncm91cHNbXSA9IHsKIAkJTlVMTAog
fTsKIAotc3RhdGljIGludCBkZl92M182X3NldF9kZl9jc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIGludCBhbGxvdykKK3N0YXRpYyBkZl92M182X3NldF9kZl9jc3RhdGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBhbGxvdykKIHsKIAlpbnQgciA9IDA7CiAKQEAgLTU0
Niw3ICs1NDYsNyBAQCBzdGF0aWMgdm9pZCBkZl92M182X3BtY19nZXRfY291bnQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJICB1aW50NjRfdCBjb25maWcsCiAJCQkJICB1aW50NjRf
dCAqY291bnQpCiB7Ci0JdWludDMyX3QgbG9fYmFzZV9hZGRyLCBoaV9iYXNlX2FkZHIsIGxvX3Zh
bCA9IDAsIGhpX3ZhbCA9IDA7CisJdWludDMyX3QgbG9fYmFzZV9hZGRyLCBoaV9iYXNlX2FkZHIs
IGxvX3ZhbCwgaGlfdmFsOwogCSpjb3VudCA9IDA7CiAKIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlw
ZSkgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/13] drm/amdgpu: irq resume should be immediately after gpu
 resume
Date: Tue, 2 Aug 2016 15:48:55 +0800
Message-ID: <1470124147-22840-2-git-send-email-David1.Zhou@amd.com>
References: <1470124147-22840-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470124147-22840-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJY2Y2NGJmNTk2NGYwZWY2NmMyMzlhYjA2NzlkNTEyNzVjYzI3MjY5OQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBlZGJiMzcwLi43ZmQ2NTFhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yMTU4LDYgKzIxNTgsNyBA
QCByZXRyeToKIAkJYW1kZ3B1X2F0b21iaW9zX3NjcmF0Y2hfcmVnc19yZXN0b3JlKGFkZXYpOwog
CX0KIAlpZiAoIXIpIHsKKwkJYW1kZ3B1X2lycV9ncHVfcmVzZXRfcmVzdW1lX2hlbHBlcihhZGV2
KTsKIAkJciA9IGFtZGdwdV9pYl9yaW5nX3Rlc3RzKGFkZXYpOwogCQlpZiAocikgewogCQkJZGV2
X2VycihhZGV2LT5kZXYsICJpYiByaW5nIHRlc3QgZmFpbGVkICglZCkuXG4iLCByKTsKQEAgLTIx
OTIsNyArMjE5Myw2IEBAIHJldHJ5OgogCQkvKiBiYWQgbmV3cywgaG93IHRvIHRlbGwgaXQgdG8g
dXNlcnNwYWNlID8gKi8KIAkJZGV2X2luZm8oYWRldi0+ZGV2LCAiR1BVIHJlc2V0IGZhaWxlZFxu
Iik7CiAJfQotCWFtZGdwdV9pcnFfZ3B1X3Jlc2V0X3Jlc3VtZV9oZWxwZXIoYWRldik7CiAKIAly
ZXR1cm4gcjsKIH0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK

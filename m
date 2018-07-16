From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/scheduler: add NULL pointer check for run queue
Date: Mon, 16 Jul 2018 10:59:40 +0800
Message-ID: <1531709980-21298-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

VG8gY2hlY2sgcnEgcG9pbnRlciBiZWZvcmUgYWRkaW5nIGVudGl0eSBpbnRvIGl0LgpUaGF0IGF2
b2lkcyBOVUxMIHBvaW50ZXIgYWNjZXNzIGluIHNvbWUgY2FzZS4KClN1Z2dlc3RlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBK
dW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hl
ZHVsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCmluZGV4
IDE2YmY0NDYuLjVlNTI2OGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
Z3B1X3NjaGVkdWxlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvZ3B1X3NjaGVk
dWxlci5jCkBAIC05MSw2ICs5MSwxMCBAQCBzdGF0aWMgdm9pZCBkcm1fc2NoZWRfcnFfYWRkX2Vu
dGl0eShzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSwKIHsKIAlpZiAoIWxpc3RfZW1wdHkoJmVudGl0
eS0+bGlzdCkpCiAJCXJldHVybjsKKwlpZiAoIXJxKSB7CisJCURSTV9FUlJPUigicnEgaXMgTlVM
TCFcbiIpOworCQlyZXR1cm47CisJfQogCXNwaW5fbG9jaygmcnEtPmxvY2spOwogCWxpc3RfYWRk
X3RhaWwoJmVudGl0eS0+bGlzdCwgJnJxLT5lbnRpdGllcyk7CiAJc3Bpbl91bmxvY2soJnJxLT5s
b2NrKTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

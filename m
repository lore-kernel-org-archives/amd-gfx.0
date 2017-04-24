From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Fix use of interruptible waiting 1. The
 signal interrupt can affect the expected behaviour. 2. There is no good
 mechanism to handle the corresponding error. When signal interrupt happens,
 unpin is not called. As a result, inside AMDGPU,
 the statistic of pin size will be wrong.
Date: Mon, 24 Apr 2017 15:34:38 -0400
Message-ID: <1493062478-12753-2-git-send-email-AlexBin.Xie@amd.com>
References: <1493062478-12753-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493062478-12753-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJNjg4OWE0ZDlkZDI3MDNiY2Y1ZDQ0OGQxOGY2YWY1MWM0OTZhOTNjOQpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCmluZGV4IDc2YmUyZDIuLjc1YmQ3NmYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKQEAgLTEy
Myw3ICsxMjMsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYmVuY2htYXJrX21vdmUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHNpemUsCiAJfQogCiAJaWYgKHNvYmopIHsKLQkJ
ciA9IGFtZGdwdV9ib19yZXNlcnZlKHNvYmosIGZhbHNlKTsKKwkJciA9IGFtZGdwdV9ib19yZXNl
cnZlKHNvYmosIHRydWUpOwogCQlpZiAobGlrZWx5KHIgPT0gMCkpIHsKIAkJCWFtZGdwdV9ib191
bnBpbihzb2JqKTsKIAkJCWFtZGdwdV9ib191bnJlc2VydmUoc29iaik7CkBAIC0xMzEsNyArMTMx
LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2JlbmNobWFya19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1bnNpZ25lZCBzaXplLAogCQlhbWRncHVfYm9fdW5yZWYoJnNvYmopOwogCX0K
IAlpZiAoZG9iaikgewotCQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoZG9iaiwgZmFsc2UpOworCQly
ID0gYW1kZ3B1X2JvX3Jlc2VydmUoZG9iaiwgdHJ1ZSk7CiAJCWlmIChsaWtlbHkociA9PSAwKSkg
ewogCQkJYW1kZ3B1X2JvX3VucGluKGRvYmopOwogCQkJYW1kZ3B1X2JvX3VucmVzZXJ2ZShkb2Jq
KTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

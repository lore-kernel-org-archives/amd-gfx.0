From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] drm/amdgpu: Fix potential issue if reserve function is
 interrupted If amdgpu_bo_reserve function is interrupted by signal,
 amdgpu_bo_kunmap function is not called.
Date: Mon, 24 Apr 2017 14:29:02 -0400
Message-ID: <1493058545-9733-1-git-send-email-AlexBin.Xie@amd.com>
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
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZGUyYjNiZTY1NDliM2FmYjhkNjExNjA5NGI1ZmZmNDk1YjE4YWRkZgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IFhpZSA8QWxleEJpbi5YaWVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKaW5kZXggYTA5YWQzY2YuLjA1MTY5NmQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTM1MCw3ICszNTAsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfdnJhbV9zY3JhdGNoX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJaWYgKGFkZXYtPnZyYW1fc2NyYXRjaC5yb2JqID09IE5VTEwpIHsKIAkJcmV0dXJuOwog
CX0KLQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoYWRldi0+dnJhbV9zY3JhdGNoLnJvYmosIGZhbHNl
KTsKKwlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoYWRldi0+dnJhbV9zY3JhdGNoLnJvYmosIHRydWUp
OwogCWlmIChsaWtlbHkociA9PSAwKSkgewogCQlhbWRncHVfYm9fa3VubWFwKGFkZXYtPnZyYW1f
c2NyYXRjaC5yb2JqKTsKIAkJYW1kZ3B1X2JvX3VucGluKGFkZXYtPnZyYW1fc2NyYXRjaC5yb2Jq
KTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

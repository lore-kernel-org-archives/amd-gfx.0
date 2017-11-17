From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove amdgpu_pm_sysfs_init in ci_dpm.c
Date: Fri, 17 Nov 2017 16:15:36 +0800
Message-ID: <1510906536-12494-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

dGhpcyBmdW5jdGlvbiB3YXMgY2FsbGVkIGluIGFtZGdwdV9kZXZpY2VfaW5pdAoKQ2hhbmdlLUlk
OiBJNjlhYTc3YmE3ZGI0MWQyMjAyYzNkNmZmZDYwNjk2NWYwY2FkMzEwNgpTaWduZWQtb2ZmLWJ5
OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvY2lfZHBtLmMgfCA1IC0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaV9kcG0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCmluZGV4IDVhNjBjMTYuLmI0N2RhNjAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCkBAIC02Mjk0LDExICs2Mjk0LDYgQEAgc3RhdGlj
IGludCBjaV9kcG1fbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKIAlpZiAoIWFtZGdwdV9kcG0pCiAJ
CXJldHVybiAwOwogCi0JLyogaW5pdCB0aGUgc3lzZnMgYW5kIGRlYnVnZnMgZmlsZXMgbGF0ZSAq
LwotCXJldCA9IGFtZGdwdV9wbV9zeXNmc19pbml0KGFkZXYpOwotCWlmIChyZXQpCi0JCXJldHVy
biByZXQ7Ci0KIAlyZXQgPSBjaV9zZXRfdGVtcGVyYXR1cmVfcmFuZ2UoYWRldik7CiAJaWYgKHJl
dCkKIAkJcmV0dXJuIHJldDsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK

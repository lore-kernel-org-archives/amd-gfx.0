From: Gang Ba <gaba-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Update VM function pointer   When VM state
 changed and system in large bar mode, make sure to use CPU update function,
 otherwise use   SDMA function.
Date: Wed, 14 Aug 2019 17:33:48 +0000
Message-ID: <1565804013-20946-1-git-send-email-gaba@amd.com>
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
Cc: "Ba, Gang" <Gang.Ba-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYmNmYWRhNTYwYTAwYzlhZWViZmQ5MjJhZTQ4ZGU5MjBlNDRhNTg2NgpTaWdu
ZWQtb2ZmLWJ5OiBHYW5nIEJhIDxnYWJhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGMxYmFm
M2QuLjdkZGNhM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0y
ODYyLDYgKzI4NjIsMTMgQEAgaW50IGFtZGdwdV92bV9tYWtlX2NvbXB1dGUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLCB1bnMKIAlXQVJOX09OQ0UoKHZt
LT51c2VfY3B1X2Zvcl91cGRhdGUgJiYgIWFtZGdwdV9nbWNfdnJhbV9mdWxsX3Zpc2libGUoJmFk
ZXYtPmdtYykpLAogCQkgICJDUFUgdXBkYXRlIG9mIFZNIHJlY29tbWVuZGVkIG9ubHkgZm9yIGxh
cmdlIEJBUiBzeXN0ZW1cbiIpOwogCisJaWYgKHZtLT51c2VfY3B1X2Zvcl91cGRhdGUpCisJCXZt
LT51cGRhdGVfZnVuY3MgPSAmYW1kZ3B1X3ZtX2NwdV9mdW5jczsKKwllbHNlCisJCXZtLT51cGRh
dGVfZnVuY3MgPSAmYW1kZ3B1X3ZtX3NkbWFfZnVuY3M7CisJZG1hX2ZlbmNlX3B1dCh2bS0+bGFz
dF91cGRhdGUpOworCXZtLT5sYXN0X3VwZGF0ZSA9IE5VTEw7CisKIAlpZiAodm0tPnBhc2lkKSB7
CiAJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=

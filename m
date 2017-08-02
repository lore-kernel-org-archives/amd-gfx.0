From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu: Use list_del_init in amdgpu_mn_unregister
Date: Tue,  1 Aug 2017 22:34:55 -0400
Message-ID: <1501641295-26353-1-git-send-email-Felix.Kuehling@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Kent.Russell-5C7GfCeVMHo@public.gmane.org

T3RoZXJ3aXNlIGJvLT5zaGFkb3dfbGlzdCAod2hpY2ggaXMgYWxpYXNlZCBieSBiby0+bW5fbGlz
dCkgd2lsbCBub3QKYXBwZWFyIGVtcHR5IGluIGFtZGdwdV90dG1fYm9fZGVzdHJveSBhbmQgY2F1
c2UgYW4gb29wcyB3aGVuIGZyZWVpbmcKZm9ybWVyIHVzZXJwdHIgQk9zLgoKU2lnbmVkLW9mZi1i
eTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfbW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tbi5jCmluZGV4IDM4ZjczOWYuLjY1NThhM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tbi5jCkBAIC0zNTksNyArMzU5LDcgQEAgdm9pZCBhbWRncHVfbW5fdW5yZWdpc3Rl
cihzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIAloZWFkID0gYm8tPm1uX2xpc3QubmV4dDsKIAogCWJv
LT5tbiA9IE5VTEw7Ci0JbGlzdF9kZWwoJmJvLT5tbl9saXN0KTsKKwlsaXN0X2RlbF9pbml0KCZi
by0+bW5fbGlzdCk7CiAKIAlpZiAobGlzdF9lbXB0eShoZWFkKSkgewogCQlzdHJ1Y3QgYW1kZ3B1
X21uX25vZGUgKm5vZGU7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==

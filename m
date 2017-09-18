From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/18] drm/amdgpu/sriov:fix missing error handling
Date: Mon, 18 Sep 2017 14:11:45 +0800
Message-ID: <1505715122-23904-2-git-send-email-Monk.Liu@amd.com>
References: <1505715122-23904-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505715122-23904-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZmM2OTQyZWQwMjIxZjMxMzRiZmJhNGQ2NmZkZTc0MzQ4NDE5MWRhMwpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jCmluZGV4IGUzOTBjMDEuLmQxYWMyN2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMKQEAgLTg0MSw4ICs4NDEsMTEgQEAgaW50IGFtZGdwdV9kcml2ZXJf
b3Blbl9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRybV9maWxlICpmaWxlX3By
aXYpCiAKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CiAJCXIgPSBhbWRncHVfbWFwX3N0
YXRpY19jc2EoYWRldiwgJmZwcml2LT52bSwgJmZwcml2LT5jc2FfdmEpOwotCQlpZiAocikKKwkJ
aWYgKHIpIHsKKwkJCWFtZGdwdV92bV9maW5pKGFkZXYsICZmcHJpdi0+dm0pOworCQkJa2ZyZWUo
ZnByaXYpOwogCQkJZ290byBvdXRfc3VzcGVuZDsKKwkJfQogCX0KIAogCW11dGV4X2luaXQoJmZw
cml2LT5ib19saXN0X2xvY2spOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=

From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Tidy up static int dce_v6_0_get_num_crtc()
Date: Mon, 15 May 2017 10:58:05 -0400
Message-ID: <20170515145805.29349-3-tom.stdenis@amd.com>
References: <20170515145805.29349-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170515145805.29349-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMgfCAxMSArKystLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZGNlX3Y2XzAuYwppbmRleCAxYjZiOWIyMmQ3ODAuLmVjN2Y3YmI3N2Y1MCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCkBAIC01MTQsMjEgKzUxNCwxNiBA
QCBzdGF0aWMgdm9pZCBkY2VfdjZfMF9zZXRfdmdhX3JlbmRlcl9zdGF0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAogc3RhdGljIGludCBkY2VfdjZfMF9nZXRfbnVtX2NydGMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0JaW50IG51bV9jcnRjID0gMDsKLQogCXN3aXRjaCAo
YWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX1RBSElUSToKIAljYXNlIENISVBfUElUQ0FJ
Uk46CiAJY2FzZSBDSElQX1ZFUkRFOgotCQludW1fY3J0YyA9IDY7Ci0JCWJyZWFrOworCQlyZXR1
cm4gNjsKIAljYXNlIENISVBfT0xBTkQ6Ci0JCW51bV9jcnRjID0gMjsKLQkJYnJlYWs7CisJCXJl
dHVybiAyOwogCWRlZmF1bHQ6Ci0JCW51bV9jcnRjID0gMDsKKwkJcmV0dXJuIDA7CiAJfQotCXJl
dHVybiBudW1fY3J0YzsKIH0KIAogdm9pZCBkY2VfdjZfMF9kaXNhYmxlX2RjZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

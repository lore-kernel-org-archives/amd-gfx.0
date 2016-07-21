From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/amdgpu: Enable UVD PG on Carrizo
Date: Thu, 21 Jul 2016 13:18:48 -0400
Message-ID: <20160721171848.32368-5-tom.stdenis@amd.com>
References: <20160721171848.32368-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160721171848.32368-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmlu
ZGV4IDY1MGE4OWJiM2M4Mi4uZDcxMWEzY2YwNmYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMK
QEAgLTE1ODAsMTEgKzE1ODAsMTUgQEAgc3RhdGljIGludCB2aV9jb21tb25fZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX0xTOwogCQkvKiByZXYwIGhhcmR3
YXJlIGRvZXNuJ3Qgc3VwcG9ydCBQRyAqLwogCQlhZGV2LT5wZ19mbGFncyA9IDA7Ci0JCWlmIChh
ZGV2LT5yZXZfaWQgIT0gMHgwMCkKKwkJaWYgKGFkZXYtPnJldl9pZCAhPSAweDAwKSB7CiAJCQlh
ZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAogCQkJCUFNRF9QR19TVVBQ
T1JUX0dGWF9TTUcgfAogCQkJCUFNRF9QR19TVVBQT1JUX0dGWF9ETUcgfAogCQkJCUFNRF9QR19T
VVBQT1JUX0dGWF9QSVBFTElORTsKKwkJCS8qIHBvd2VycGxheSBVVkQgUEcgZG9lc24ndCB3b3Jr
IHlldCAqLworCQkJaWYgKCFhbWRncHVfcG93ZXJwbGF5KQorCQkJCWFkZXYtPnBnX2ZsYWdzIHw9
IEFNRF9QR19TVVBQT1JUX1VWRDsKKwkJfQogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2
LT5yZXZfaWQgKyAweDE7CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9TVE9ORVk6Ci0tIAoyLjkuMgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

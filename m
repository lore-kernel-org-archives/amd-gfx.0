From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/14] drm/amd/amdgpu: Enable carrizo GFX PG
Date: Thu, 28 Jul 2016 10:19:07 -0400
Message-ID: <20160728141912.18140-10-tom.stdenis@amd.com>
References: <20160728141912.18140-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160728141912.18140-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4IDliYTY0OTg5ZjA5
Mi4uNGZhOWZlYTU0MWE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAgLTE1NzgsNyArMTU3
OCwxMyBAQCBzdGF0aWMgaW50IHZpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJ
CUFNRF9DR19TVVBQT1JUX0hEUF9MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX01HQ0cgfAog
CQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9MUzsKKwkJLyogcmV2MCBoYXJkd2FyZSByZXF1aXJlcyB3
b3JrYXJvdW5kcyB0byBzdXBwb3J0IFBHICovCiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKKwkJaWYg
KGFkZXYtPnJldl9pZCAhPSAweDAwKSB7CisJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQ
UE9SVF9HRlhfUEcgfAorCQkJCUFNRF9QR19TVVBQT1JUX0dGWF9TTUcgfAorCQkJCUFNRF9QR19T
VVBQT1JUX0dGWF9QSVBFTElORTsKKwkJfQogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2
LT5yZXZfaWQgKyAweDE7CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9TVE9ORVk6Ci0tIAoyLjkuMgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

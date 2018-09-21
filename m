From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/9] drm/amdgpu: implement ENABLED_SMC_FEATURES_MASK sensor
 for vega20
Date: Thu, 20 Sep 2018 22:54:48 -0500
Message-ID: <20180921035449.6996-8-alexander.deucher@amd.com>
References: <20180921035449.6996-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180921035449.6996-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U28gd2UgY2FuIHF1ZXJ5IHdoYXQgZmVhdHVyZXMgYXJlIGVuYWJsZWQgZm9yIGRlYnVnZ2luZy4K
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYyB8
IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jCmluZGV4IDI2MGUw
ZTQ4ZGNkNi4uMmE1NTRmOWVkY2RhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYwpAQCAtMTk0MSw2ICsxOTQxLDExIEBAIHN0YXRp
YyBpbnQgdmVnYTIwX3JlYWRfc2Vuc29yKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGludCBpZHgs
CiAJCSpzaXplID0gMTY7CiAJCXJldCA9IHZlZ2EyMF9nZXRfZ3B1X3Bvd2VyKGh3bWdyLCAodWlu
dDMyX3QgKil2YWx1ZSk7CiAJCWJyZWFrOworCWNhc2UgQU1ER1BVX1BQX1NFTlNPUl9FTkFCTEVE
X1NNQ19GRUFUVVJFU19NQVNLOgorCQlyZXQgPSB2ZWdhMjBfZ2V0X2VuYWJsZWRfc21jX2ZlYXR1
cmVzKGh3bWdyLCAodWludDY0X3QgKil2YWx1ZSk7CisJCWlmICghcmV0KQorCQkJKnNpemUgPSA4
OworCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXQgPSAtRUlOVkFMOwogCQlicmVhazsKLS0gCjIu
MTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

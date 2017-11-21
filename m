From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/radeon: fix possible memory leak in radeon_bo_create
Date: Mon, 20 Nov 2017 23:36:57 -0500
Message-ID: <20171121043657.10247-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

aWYgdHRtX2JvX2luaXQgZmFpbHMsIGRvbid0IGxlYWsgdGhlIGJvIG9iamVjdC4KClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5jCmlu
ZGV4IDA5MzU5NDk3NjEyNi4uNTNjNWJiNmMyNWU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9vYmplY3QuYwpAQCAtMjYyLDYgKzI2Miw4IEBAIGludCByYWRlb25fYm9fY3JlYXRlKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAogCQkJYWNjX3NpemUsIHNnLCByZXN2LCAmcmFkZW9u
X3R0bV9ib19kZXN0cm95KTsKIAl1cF9yZWFkKCZyZGV2LT5wbS5tY2xrX2xvY2spOwogCWlmICh1
bmxpa2VseShyICE9IDApKSB7CisJCWRybV9nZW1fb2JqZWN0X3JlbGVhc2UoJmJvLT5nZW1fYmFz
ZSk7CisJCWtmcmVlKGJvKTsKIAkJcmV0dXJuIHI7CiAJfQogCSpib19wdHIgPSBibzsKLS0gCjIu
MTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

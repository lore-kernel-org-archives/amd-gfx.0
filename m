From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/5] drm/amd/powerplay: support VCN powergate status retrieval
 for SW SMU
Date: Mon, 22 Jul 2019 11:15:29 +0800
Message-ID: <20190722031531.23437-4-evan.quan@amd.com>
References: <20190722031531.23437-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190722031531.23437-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

Q29tbW9ubHkgdXNlZCBmb3IgVkNOIHBvd2VyZ2F0ZSBzdGF0dXMgcmV0cmlldmFsIGZvciBTVyBT
TVUuCgpDaGFuZ2UtSWQ6IEliYzJmNDk4ODQ4ZjcyOGViNzcyN2NkM2ZhODg5ZTkxYTJiMDlkMDdi
ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIHwgNCArKysrCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCmluZGV4IDQxNmY5YTgzN2ZhOC4uNGUxOGYzM2ExYmFiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC0zMzYsNiArMzM2LDEwIEBAIGlu
dCBzbXVfY29tbW9uX3JlYWRfc2Vuc29yKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIGFt
ZF9wcF9zZW5zb3JzIHNlbnNvciwKIAkJKih1aW50MzJfdCAqKWRhdGEgPSBzbXVfZmVhdHVyZV9p
c19lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVfRFBNX1ZDRV9CSVQpID8gMSA6IDA7CiAJCSpzaXpl
ID0gNDsKIAkJYnJlYWs7CisJY2FzZSBBTURHUFVfUFBfU0VOU09SX1ZDTl9QT1dFUjoKKwkJKih1
aW50MzJfdCAqKWRhdGEgPSBzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVf
VkNOX1BHX0JJVCkgPyAxIDogMDsKKwkJKnNpemUgPSA0OworCQlicmVhazsKIAlkZWZhdWx0Ogog
CQlyZXQgPSAtRUlOVkFMOwogCQlicmVhazsKLS0gCjIuMjIuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4

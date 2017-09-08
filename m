From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/16] drm/amd/powerplay:  Add PP_CAP() macro
Date: Fri,  8 Sep 2017 12:01:38 -0400
Message-ID: <20170908160149.9349-6-tom.stdenis@amd.com>
References: <20170908160149.9349-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170908160149.9349-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

VG8gcmVwbGFjZSBjb21tb24gbGVuZ3RoeSBzZXF1ZW5jZSB0aGF0IHdvdWxkIGNyZWF0ZQpyZWFs
bHkgbG9uZyBsaW5lcyBhbGwgb3Zlci4KClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9t
LnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMv
aGFyZHdhcmVtYW5hZ2VyLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2hhcmR3YXJl
bWFuYWdlci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2hhcmR3YXJlbWFu
YWdlci5oCmluZGV4IGE0YzhiMDliNmYxNC4uMDNhZGVjZTRlZmVhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaGFyZHdhcmVtYW5hZ2VyLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2hhcmR3YXJlbWFuYWdlci5oCkBAIC0yODMs
NiArMjgzLDggQEAgc3RhdGljIGlubGluZSBib29sIHBobV9jYXBfZW5hYmxlZChjb25zdCB1aW50
MzJfdCAqY2FwcywgZW51bSBwaG1fcGxhdGZvcm1fY2FwcwogCQkgICgxVUwgPDwgKGMgJiAoUEhN
X01BWF9OVU1fQ0FQU19CSVRTX1BFUl9GSUVMRCAtIDEpKSkpKTsKIH0KIAorI2RlZmluZSBQUF9D
QVAoYykgcGhtX2NhcF9lbmFibGVkKGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9yLnBsYXRmb3Jt
Q2FwcywgKGMpKQorCiAjZGVmaW5lIFBQX1BDSUVHZW5JbnZhbGlkICAweGZmZmYKIGVudW0gUFBf
UENJRUdlbiB7CiAgICAgUFBfUENJRUdlbjEgPSAwLCAgICAgICAgICAgICAgICAvKiBQQ0lFIDEu
MCAtIFRyYW5zZmVyIHJhdGUgb2YgMi41IEdUL3MgKi8KLS0gCjIuMTIuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

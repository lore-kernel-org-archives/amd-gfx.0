From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/14] drm/amdgpu: fix to miss adding thermal controller
Date: Tue, 30 Aug 2016 19:50:06 +0800
Message-ID: <1472557811-8015-10-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

VGhlcm1hbCBjb250cm9sbGVyIGlzbid0IGluaXRlZCBkdXJpbmcgc2kgZHBtIHN3X2luaXQgcGhh
c2UuCgpDaGFuZ2UtSWQ6IEllOWRkY2Q3MDI2MDY3ZTE5YmIwZTMwMGNmODVjNzk5NDhlNzI3NWE5
ClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lf
ZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwppbmRleCA5MDg0MmMw
Li41ZjFlNWZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAtNzI4MSw2ICs3
MjgxLDggQEAgc3RhdGljIGludCBzaV9wYXJzZV9wb3dlcl90YWJsZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkJcmV0dXJuIC1FSU5WQUw7CiAJcG93ZXJfaW5mbyA9ICh1bmlvbiBwb3dl
cl9pbmZvICopKG1vZGVfaW5mby0+YXRvbV9jb250ZXh0LT5iaW9zICsgZGF0YV9vZmZzZXQpOwog
CisJYW1kZ3B1X2FkZF90aGVybWFsX2NvbnRyb2xsZXIoYWRldik7CisKIAlzdGF0ZV9hcnJheSA9
IChzdHJ1Y3QgX1N0YXRlQXJyYXkgKikKIAkJKG1vZGVfaW5mby0+YXRvbV9jb250ZXh0LT5iaW9z
ICsgZGF0YV9vZmZzZXQgKwogCQkgbGUxNl90b19jcHUocG93ZXJfaW5mby0+cHBsaWIudXNTdGF0
ZUFycmF5T2Zmc2V0KSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==

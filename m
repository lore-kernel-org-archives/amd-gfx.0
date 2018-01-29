From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/12] drm/ttm: Fix coding style in ttm_bo_move_memcpy()
Date: Mon, 29 Jan 2018 08:55:08 -0500
Message-ID: <20180129135513.22538-8-tom.stdenis@amd.com>
References: <20180129135513.22538-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180129135513.22538-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QWRkIG1pc3Npbmcge30gYnJhY2VzLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20u
c3RkZW5pc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jIGIvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCmluZGV4IDE1M2RlMWJmMDIzMi4uMzNmZmUyODZmM2E1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCkBAIC00MDIsOCArNDAyLDkgQEAgaW50IHR0
bV9ib19tb3ZlX21lbWNweShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJCQkJICAg
IFBBR0VfS0VSTkVMKTsKIAkJCXJldCA9IHR0bV9jb3B5X2lvX3R0bV9wYWdlKHR0bSwgb2xkX2lv
bWFwLCBwYWdlLAogCQkJCQkJICAgcHJvdCk7Ci0JCX0gZWxzZQorCQl9IGVsc2UgewogCQkJcmV0
ID0gdHRtX2NvcHlfaW9fcGFnZShuZXdfaW9tYXAsIG9sZF9pb21hcCwgcGFnZSk7CisJCX0KIAkJ
aWYgKHJldCkKIAkJCWdvdG8gb3V0MTsKIAl9Ci0tIAoyLjE0LjMKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

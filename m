From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/12] drm/ttm: Fix indentation in ttm_bo_move_memcpy()
Date: Fri, 26 Jan 2018 13:29:08 -0500
Message-ID: <20180126182911.20761-10-tom.stdenis@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126182911.20761-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm9fdXRpbC5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5j
CmluZGV4IDE1M2RlMWJmMDIzMi4uMzNmZmUyODZmM2E1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9ib191dGlsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9f
dXRpbC5jCkBAIC00MDIsOCArNDAyLDkgQEAgaW50IHR0bV9ib19tb3ZlX21lbWNweShzdHJ1Y3Qg
dHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJCQkJICAgIFBBR0VfS0VSTkVMKTsKIAkJCXJldCA9
IHR0bV9jb3B5X2lvX3R0bV9wYWdlKHR0bSwgb2xkX2lvbWFwLCBwYWdlLAogCQkJCQkJICAgcHJv
dCk7Ci0JCX0gZWxzZQorCQl9IGVsc2UgewogCQkJcmV0ID0gdHRtX2NvcHlfaW9fcGFnZShuZXdf
aW9tYXAsIG9sZF9pb21hcCwgcGFnZSk7CisJCX0KIAkJaWYgKHJldCkKIAkJCWdvdG8gb3V0MTsK
IAl9Ci0tIAoyLjE0LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] drm/radeon/si: add dpm quirk for Oland
Date: Wed, 15 Mar 2017 09:01:29 -0400
Message-ID: <1489582890-17915-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T0xBTkQgMHgxMDAyOjB4NjYwNCAweDEwMjg6MHgwNjZGIDB4MDAgc2VlbXMgdG8gaGF2ZSBwcm9i
bGVtcwp3aXRoIGhpZ2hlciBzY2xrcy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKLS0tCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Np
X2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwppbmRleCBkMTJiODk3Li43
MmUxNTg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKQEAgLTI5ODQsNiArMjk4NCwxMiBAQCBz
dGF0aWMgdm9pZCBzaV9hcHBseV9zdGF0ZV9hZGp1c3RfcnVsZXMoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYsCiAJCSAgICAocmRldi0+cGRldi0+ZGV2aWNlID09IDB4NjY2NykpIHsKIAkJCW1h
eF9zY2xrID0gNzUwMDA7CiAJCX0KKwl9IGVsc2UgaWYgKHJkZXYtPmZhbWlseSA9PSBDSElQX09M
QU5EKSB7CisJCWlmICgocmRldi0+cGRldi0+ZGV2aWNlID09IDB4NjYwNCkgJiYKKwkJICAgIChy
ZGV2LT5wZGV2LT5zdWJzeXN0ZW1fdmVuZG9yID09IDB4MTAyOCkgJiYKKwkJICAgIChyZGV2LT5w
ZGV2LT5zdWJzeXN0ZW1fZGV2aWNlID09IDB4MDY2RikpIHsKKwkJCW1heF9zY2xrID0gNzUwMDA7
CisJCX0KIAl9CiAKIAlpZiAocnBzLT52Y2VfYWN0aXZlKSB7Ci0tIAoyLjUuNQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

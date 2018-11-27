From: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drm: radeon: fix overflow on 32bit systems
Date: Tue, 27 Nov 2018 11:50:17 +0000
Message-ID: <HK0PR01MB21638498C7DAF86591D36AB0ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>
Cc: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RnJvbTogWW91bmcgWGlhbyA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KCnRoZSB0eXBlIG1lbS0+c3Rh
cnQgaXMgdW5zaWduZWQgbG9uZywgc28gdGhpcyBjYW4gb3ZlcmZsb3cgb24KMzJiaXQgc3lzdGVt
LCBzaW5jZSB0aGUgdHlwZSBhZGRyIGlzIHVpbnQ2NF90LgoKU2lnbmVkLW9mZi1ieTogWW91bmcg
WGlhbyA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl92bS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMKaW5kZXggN2YxYTljNy4uNTE1NTlk
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jCkBAIC05NDYsNyArOTQ2LDcgQEAgaW50
IHJhZGVvbl92bV9ib191cGRhdGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCiAJCWJvX3Zh
LT5mbGFncyAmPSB+UkFERU9OX1ZNX1BBR0VfV1JJVEVBQkxFOwogCiAJaWYgKG1lbSkgewotCQlh
ZGRyID0gbWVtLT5zdGFydCA8PCBQQUdFX1NISUZUOworCQlhZGRyID0gKHU2NCltZW0tPnN0YXJ0
IDw8IFBBR0VfU0hJRlQ7CiAJCWlmIChtZW0tPm1lbV90eXBlICE9IFRUTV9QTF9TWVNURU0pIHsK
IAkJCWJvX3ZhLT5mbGFncyB8PSBSQURFT05fVk1fUEFHRV9WQUxJRDsKIAkJfQotLSAKMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

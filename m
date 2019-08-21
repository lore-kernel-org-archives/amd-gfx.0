From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 37/37] drm/amdgpu: enable VCN DPG for Renoir
Date: Wed, 21 Aug 2019 17:23:59 -0500
Message-ID: <20190821222359.13578-38-alexander.deucher@amd.com>
References: <20190821222359.13578-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190821222359.13578-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>, Thong Thai <thong.thai-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVGhvbmcgVGhhaSA8dGhvbmcudGhhaUBhbWQuY29tPgoKVGhpcyB3aWxsIGVuYWJsZSBp
bmRpcmVjdCBTUkFNIGxvYWRpbmcgZm9yIFZDTiBEUEcgbW9kZSBpbml0aWFsaXphdGlvbi4KClNp
Z25lZC1vZmYtYnk6IFRob25nIFRoYWkgPHRob25nLnRoYWlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCA1YzIxMWZhMDMzMjgu
LmZlMjIxMmRmMTJhMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC0xMTczLDcg
KzExNzMsOSBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRs
ZSkKIAkJCQkgQU1EX0NHX1NVUFBPUlRfQVRIVUJfTFMgfAogCQkJCSBBTURfQ0dfU1VQUE9SVF9B
VEhVQl9NR0NHIHwKIAkJCQkgQU1EX0NHX1NVUFBPUlRfREZfTUdDRzsKLQkJYWRldi0+cGdfZmxh
Z3MgPSBBTURfUEdfU1VQUE9SVF9TRE1BOworCQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQ
T1JUX1NETUEgfAorCQkJCSBBTURfUEdfU1VQUE9SVF9WQ04gfAorCQkJCSBBTURfUEdfU1VQUE9S
VF9WQ05fRFBHOwogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDkx
OwogCiAJCWlmIChhZGV2LT5wbS5wcF9mZWF0dXJlICYgUFBfR0ZYT0ZGX01BU0spCi0tIAoyLjIw
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

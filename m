From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 31/42] drm/amd/soc15: Add external_rev_id for vega12.
Date: Wed, 21 Mar 2018 08:46:28 -0500
Message-ID: <20180321134639.18782-31-alexander.deucher@amd.com>
References: <20180321134639.18782-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180321134639.18782-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KCkFkZCBleHRlcm5hbF9yZXZfaWQg
Zm9yIHZlZ2ExMi4KClNpZ25lZC1vZmYtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMKaW5kZXggMGFkOTI3MmM3YTVkLi5lMzA4YzNjNmNhNGYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuYwpAQCAtNjcyLDcgKzY3Miw3IEBAIHN0YXRpYyBpbnQgc29jMTVfY29t
bW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfVkNFX01HQ0cg
fAogCQkJQU1EX0NHX1NVUFBPUlRfVVZEX01HQ0c7CiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKLQkJ
YWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0gMHgxOyAvKiA/Pz8gKi8KKwkJYWRldi0+ZXh0ZXJuYWxf
cmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHgxNDsKIAkJYnJlYWs7CiAJY2FzZSBDSElQX1JBVkVO
OgogCQlhZGV2LT5jZ19mbGFncyA9IEFNRF9DR19TVVBQT1JUX0dGWF9NR0NHIHwKLS0gCjIuMTMu
NgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

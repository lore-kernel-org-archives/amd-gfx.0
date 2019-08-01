From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/36] drm/amdgpu: initialize cg/pg flags and external rev id
 for navi12
Date: Thu,  1 Aug 2019 15:29:28 -0500
Message-ID: <20190801202957.29791-8-alexander.deucher@amd.com>
References: <20190801202957.29791-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801202957.29791-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KCmRvbid0IGVuYWJsZSBh
bnkgY2cvcGcgZmVhdHVyZXMgeWV0LgoKdjI6IGNhbGN1bGF0ZSBleHRlcm5hbCByZXZpc2lvbiBp
ZCBmcm9tIHJldmlzaW9uIGlkIHNvIHRoYXQgd2UgY2FuCiAgICBkaWZmZXJlbnRpYXRlIG5hdmkx
MiBBMCBmcm9tIEExIGRpcmVjdGx5LgoKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFv
amllLnl1YW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMK
aW5kZXggMWUwODUyYzI4YzkzLi5iZGI2ZmE0Njc0YjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYu
YwpAQCAtNTk1LDYgKzU5NSwxMSBAQCBzdGF0aWMgaW50IG52X2NvbW1vbl9lYXJseV9pbml0KHZv
aWQgKmhhbmRsZSkKIAkJCUFNRF9QR19TVVBQT1JUX1ZDTl9EUEc7CiAJCWFkZXYtPmV4dGVybmFs
X3Jldl9pZCA9IGFkZXYtPnJldl9pZCArIDB4MTsgLyogPz8/ICovCiAJCWJyZWFrOworCWNhc2Ug
Q0hJUF9OQVZJMTI6CisJCWFkZXYtPmNnX2ZsYWdzID0gMDsKKwkJYWRldi0+cGdfZmxhZ3MgPSAw
OworCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweGE7CisJCWJyZWFr
OwogCWRlZmF1bHQ6CiAJCS8qIEZJWE1FOiBub3Qgc3VwcG9ydGVkIHlldCAqLwogCQlyZXR1cm4g
LUVJTlZBTDsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4

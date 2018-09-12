From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/21] drm/amdgpu: Add pg support for gfxoff for PCO
Date: Wed, 12 Sep 2018 13:56:25 -0500
Message-ID: <20180912185632.30062-15-alexander.deucher@amd.com>
References: <20180912185632.30062-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180912185632.30062-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4KCkFkZCBwZyBzdXBwb3J0
IGZvciBnZnhvZmYuCgpTaWduZWQtb2ZmLWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0Bh
bWQuY29tPgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMKaW5kZXggZDNiNzNhZmNiODcxLi4yNTM5ZmE3Yjk1OTQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwpAQCAtNzQwLDcgKzc0MCwxMCBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1v
bl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTUdDRyB8
CiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX0xTOwogCi0JCWFkZXYtPnBnX2ZsYWdzID0gMDsKKwkJ
aWYgKGFkZXYtPnBvd2VycGxheS5wcF9mZWF0dXJlICYgUFBfR0ZYT0ZGX01BU0spCisJCQlhZGV2
LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAorCQkJCUFNRF9QR19TVVBQT1JU
X0NQIHwKKwkJCQlBTURfUEdfU1VQUE9SVF9STENfU01VX0hTOwogCiAJCWFkZXYtPmV4dGVybmFs
X3Jldl9pZCA9IGFkZXYtPnJldl9pZCArIDB4NDE7CiAJCWJyZWFrOwotLSAKMi4xMy42CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

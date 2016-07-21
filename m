From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] drm/amd/amdgpu: Re-enable PG for GFX on Stoney
Date: Thu, 21 Jul 2016 13:18:46 -0400
Message-ID: <20160721171848.32368-3-tom.stdenis@amd.com>
References: <20160721171848.32368-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160721171848.32368-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

V2l0aCBTTVUgU0NMSyBhbmQgQ1AgUEcgZGlzYWJsZWQgdGVzdGluZyBwYXNzZXMuCgpTaWduZWQt
b2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmkuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYwppbmRleCBlNTNi
ZWM4N2VjMGYuLjY1MGE4OWJiM2M4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCkBAIC0xNjAz
LDcgKzE2MDMsMTAgQEAgc3RhdGljIGludCB2aV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5k
bGUpCiAJCQlBTURfQ0dfU1VQUE9SVF9IRFBfTFMgfAogCQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9N
R0NHIHwKIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFM7Ci0JCWFkZXYtPnBnX2ZsYWdzID0gMDsK
KwkJYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBPUlRfR0ZYX1BHIHwKKwkJCUFNRF9QR19T
VVBQT1JUX0dGWF9TTUcgfAorCQkJQU1EX1BHX1NVUFBPUlRfR0ZYX0RNRyB8CisJCQlBTURfUEdf
U1VQUE9SVF9HRlhfUElQRUxJTkU7CiAJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJl
dl9pZCArIDB4MTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKLS0gCjIuOS4yCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

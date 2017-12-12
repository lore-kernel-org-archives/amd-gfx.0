From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: drop scratch regs save and restore from GPU
 reset handling
Date: Tue, 12 Dec 2017 15:27:19 -0500
Message-ID: <20171212202720.6954-2-alexander.deucher@amd.com>
References: <20171212202720.6954-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171212202720.6954-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhlIGJhc2UgZHJpdmVyIGRvZXNuJ3QgbWVzcyB3aXRo
IHRoZXNlLgpTb21lIGNvbXBvbmVudHMgaW50ZXJhY3Qgd2l0aCB0aGVzZSBkaXJlY3RseSBzbyBs
ZXQgdGhlIGNvbXBvbmVudHMKaGFuZGxlIHRoZXNlIGRpcmVjdGx5LgoKU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCBjYTFjZjhhNzFkZGEuLjA0NmI5ZDViYzE0ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjg5Niw5ICsyODk2LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90KiByZXNl
dF9mbGFncykKIAkJciA9IGFtZGdwdV9zdXNwZW5kKGFkZXYpOwogCiByZXRyeToKLQkJYW1kZ3B1
X2F0b21iaW9zX3NjcmF0Y2hfcmVnc19zYXZlKGFkZXYpOwogCQlyID0gYW1kZ3B1X2FzaWNfcmVz
ZXQoYWRldik7Ci0JCWFtZGdwdV9hdG9tYmlvc19zY3JhdGNoX3JlZ3NfcmVzdG9yZShhZGV2KTsK
IAkJLyogcG9zdCBjYXJkICovCiAJCWFtZGdwdV9hdG9tX2FzaWNfaW5pdChhZGV2LT5tb2RlX2lu
Zm8uYXRvbV9jb250ZXh0KTsKIAotLSAKMi4xMy42CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

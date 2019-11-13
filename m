From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Reserve bad pages after ASIC was reset.
Date: Wed, 13 Nov 2019 17:45:25 -0500
Message-ID: <1573685125-2335-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573685125-2335-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, guchun.chen-5C7GfCeVMHo@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org

UHJvYmxlbToKVGhlcmUgaXMgbm8gcG9pbnQgdG8gcmVzZXJ2ZSBiYWQgcGFnZXMgYmVmb3JlIEdQ
VSByZXNldCBhcwppdCB3YXMgZG9uZSB1bnRpbGwgbm93IHNpbmNlIHdlIG5lZWQgdG8gZG8gaXQg
YWZ0ZXIgQVNJQyB3YXMKcmVzZXQgYXMgd2UgbG9zZSBhbGwgcmVzZXJ2YXRpb24gZHVyaW5nIEFT
SUMgcmVzZXQuCgpGaXg6CkNhbGwgYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyBhZnRlciBB
U0lDIGlzIHJlc2V0IGFuZCBub3QgYmVmb3JlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6
b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmlu
ZGV4IGYyZmVmZjQuLmVhYWMyYjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKQEAgLTM4MDQsNiArMzgwNCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kb19h
c2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlLAogCQkJCQkJYnJlYWs7CiAJ
CQkJfQogCQkJfQorCisJCQkvKiBNYXJrIHZyYW0gcGFnZXMgd2l0aCBlcnJvcnMgYXMgYmFkIGFm
dGVyIEFTSUMgd2FzIHJlc2V0ICovCisJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBk
ZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpCisJCQkgICAgICAgYW1kZ3B1X3Jhc19y
ZXNlcnZlX2JhZF9wYWdlcyh0bXBfYWRldik7CiAJCX0KIAl9CiAKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

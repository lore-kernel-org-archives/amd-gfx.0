From: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <koalinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Release the mutex hold before backtracing for not supported
 mxgpu.
Date: Tue, 19 Dec 2017 10:37:32 +0200
Message-ID: <20171219083732.18082-1-koalinux@gmail.com>
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
Cc: =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <koalinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

VGhpcyBwYXRjaCByZWxlYXNlcyB0aGUgbXV0ZXggaGVsZCBzb29uIGJlZm9yZSBlbnRlcmluZyB0
aGUgaW5pdGlhbGl6YXRpb24KZnVuY3Rpb24gaW4gY2FzZSB0aGUgZGV2aWNlIGRvZXNuJ3Qgc3Vw
cG9ydCBteGdwdS4KClNpZ25lZC1vZmYtYnk6IEpvc8OpIFBla2thcmluZW4gPGtvYWxpbnV4QGdt
YWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bXhncHVfdmkuYwppbmRleCBjMjVhODMxZjk0ZWMuLmNhYzFkOGIwMDNlNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9teGdwdV92aS5jCkBAIC0zMDcsNiArMzA3LDcgQEAgdm9pZCB4Z3B1X3Zp
X2luaXRfZ29sZGVuX3JlZ2lzdGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCQkJ
CSB4Z3B1X3RvbmdhX2dvbGRlbl9jb21tb25fYWxsKSk7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CisJ
CW11dGV4X3VubG9jaygmYWRldi0+Z3JibV9pZHhfbXV0ZXgpOwogCQlCVUdfT04oIkRvZXNuJ3Qg
c3VwcG9ydCBjaGlwIHR5cGUuXG4iKTsKIAkJYnJlYWs7CiAJfQotLSAKMi4xMy42CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

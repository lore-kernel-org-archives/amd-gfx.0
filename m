From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 038/100] drm/amdgpu: don't validate TILE_SPLIT on GFX9
Date: Mon, 20 Mar 2017 16:29:33 -0400
Message-ID: <1490041835-11255-24-git-send-email-alexander.deucher@amd.com>
References: <1490041835-11255-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490041835-11255-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IE1hcmVrIE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5jb20+CkFja2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jCmluZGV4IGUxZTY3M2MuLjQzNGM5MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTgxNSw3ICs4MTUsMTAgQEAgaW50IGFtZGdwdV9ib19m
YmRldl9tbWFwKHN0cnVjdCBhbWRncHVfYm8gKmJvLAogCiBpbnQgYW1kZ3B1X2JvX3NldF90aWxp
bmdfZmxhZ3Moc3RydWN0IGFtZGdwdV9ibyAqYm8sIHU2NCB0aWxpbmdfZmxhZ3MpCiB7Ci0JaWYg
KEFNREdQVV9USUxJTkdfR0VUKHRpbGluZ19mbGFncywgVElMRV9TUExJVCkgPiA2KQorCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7CisK
KwlpZiAoYWRldi0+ZmFtaWx5IDw9IEFNREdQVV9GQU1JTFlfQ1ogJiYKKwkgICAgQU1ER1BVX1RJ
TElOR19HRVQodGlsaW5nX2ZsYWdzLCBUSUxFX1NQTElUKSA+IDYpCiAJCXJldHVybiAtRUlOVkFM
OwogCiAJYm8tPnRpbGluZ19mbGFncyA9IHRpbGluZ19mbGFnczsKLS0gCjIuNS41CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

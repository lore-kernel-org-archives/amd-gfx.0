From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/9] drm/amdgpu: enable gfx clock gating for Arcturus
Date: Thu, 8 Aug 2019 18:21:49 +0800
Message-ID: <1565259714-30357-2-git-send-email-le.ma@amd.com>
References: <1565259714-30357-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565259714-30357-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

SW5pdCBnZnggTUdDRy9MUywgQ0dDRy9MUywgQ1BfTFMgZmxhZy4KCkNoYW5nZS1JZDogSTg4ZGI3
NmQxYjhmMmIyY2VjY2UxMDg0NmE0ZDIyZWVjNjM4ZWVhOGEKU2lnbmVkLW9mZi1ieTogTGUgTWEg
PGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8
IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggMTVmNjM1Ni4uMDA3NThiZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC0xMDEzLDcgKzEwMTMsMTEgQEAgc3RhdGlj
IGludCBzb2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCWJyZWFrOwogCWNh
c2UgQ0hJUF9BUkNUVVJVUzoKIAkJYWRldi0+YXNpY19mdW5jcyA9ICZ2ZWdhMjBfYXNpY19mdW5j
czsKLQkJYWRldi0+Y2dfZmxhZ3MgPSAwOworCQlhZGV2LT5jZ19mbGFncyA9IEFNRF9DR19TVVBQ
T1JUX0dGWF9NR0NHIHwKKwkJCUFNRF9DR19TVVBQT1JUX0dGWF9NR0xTIHwKKwkJCUFNRF9DR19T
VVBQT1JUX0dGWF9DR0NHIHwKKwkJCUFNRF9DR19TVVBQT1JUX0dGWF9DR0xTIHwKKwkJCUFNRF9D
R19TVVBQT1JUX0dGWF9DUF9MUzsKIAkJYWRldi0+cGdfZmxhZ3MgPSAwOwogCQlhZGV2LT5leHRl
cm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDMyOwogCQlicmVhazsKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

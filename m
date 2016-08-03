From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] drm/amd/amdgpu:  Don't set VCE CG in startup
Date: Wed,  3 Aug 2016 11:51:39 -0400
Message-ID: <20160803155142.27161-4-tom.stdenis@amd.com>
References: <20160803155142.27161-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160803155142.27161-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

SXQncyBoYW5kbGVkIGJ5IERQTS9QUCBwcm9wZXJseS4KClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBE
ZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y2VfdjNfMC5jIHwgNCAtLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwppbmRleCA5MzYwNGJiNzgyNTcuLjlkMTky
NGU0ZTJiYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCkBAIC0yOTcsMTAg
KzI5Nyw2IEBAIHN0YXRpYyBpbnQgdmNlX3YzXzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiAJCS8qIGNsZWFyIEJVU1kgZmxhZyAqLwogCQlXUkVHMzJfUChtbVZDRV9TVEFUVVMs
IDAsIH5WQ0VfU1RBVFVTX19KT0JfQlVTWV9NQVNLKTsKIAotCQkvKiBTZXQgQ2xvY2stR2F0aW5n
IG9mZiAqLwotCQlpZiAoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9WQ0VfTUdDRykK
LQkJCXZjZV92M18wX3NldF92Y2Vfc3dfY2xvY2tfZ2F0aW5nKGFkZXYsIGZhbHNlKTsKLQogCQlp
ZiAocikgewogCQkJRFJNX0VSUk9SKCJWQ0Ugbm90IHJlc3BvbmRpbmcsIGdpdmluZyB1cCEhIVxu
Iik7CiAJCQltdXRleF91bmxvY2soJmFkZXYtPmdyYm1faWR4X211dGV4KTsKLS0gCjIuOS4yCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

From: "Grigorev, Slava" <Slava.Grigorev-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Fix Xorg abort on exit in RHEL 7.7+
Date: Tue, 10 Sep 2019 19:47:30 +0000
Message-ID: <20190910194637.29819-1-slava.grigorev@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Grigorev, Slava" <Slava.Grigorev-5C7GfCeVMHo@public.gmane.org>

UkhFTCBhZGRzIGFuIGV4dHJhIExlYXZlVlQgY2FsbHMgdG8geGY4NkNydGNDbG9zZVNjcmVlbiB3
aGVuIHRoZXkgYnVpbGQgWCBzZXJ2ZXIKZm9yIHRoZSBwdXJwb3NlIHRvIGRyb3AgZHJtIG1hc3Rl
ci4KClNpZ25lZC1vZmYtYnk6IFNsYXZhIEdyaWdvcmV2IDxzbGF2YS5ncmlnb3JldkBhbWQuY29t
PgotLS0KIHNyYy9hbWRncHVfa21zLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvYW1kZ3B1X2ttcy5jIGIv
c3JjL2FtZGdwdV9rbXMuYwppbmRleCAzMjgwOTcyLi45ZWZjNDgyIDEwMDY0NAotLS0gYS9zcmMv
YW1kZ3B1X2ttcy5jCisrKyBiL3NyYy9hbWRncHVfa21zLmMKQEAgLTIyODUsNyArMjI4NSw5IEBA
IHZvaWQgQU1ER1BVTGVhdmVWVF9LTVMoU2NybkluZm9QdHIgcFNjcm4pCiAJCQkJc3RydWN0IGRy
bW1vZGVfZmIgKmJsYWNrX2ZiID0KIAkJCQkJYW1kZ3B1X3BpeG1hcF9nZXRfZmIoYmxhY2tfc2Nh
bm91dC5waXhtYXApOwogCi0JCQkJYW1kZ3B1X3BpeG1hcF9jbGVhcihibGFja19zY2Fub3V0LnBp
eG1hcCk7CisJCQkJaWYgKCFkaXhQcml2YXRlS2V5UmVnaXN0ZXJlZChyclByaXZLZXkpKQorCQkJ
CQlhbWRncHVfcGl4bWFwX2NsZWFyKGJsYWNrX3NjYW5vdXQucGl4bWFwKTsKKwogCQkJCWFtZGdw
dV9nbGFtb3JfZmluaXNoKHBTY3JuKTsKIAogCQkJCWZvciAoaSA9IDA7IGkgPCB4Zjg2X2NvbmZp
Zy0+bnVtX2NydGM7IGkrKykgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=

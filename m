From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amdgpu:timeout set to equal with VI
Date: Wed, 5 Apr 2017 17:11:11 +0800
Message-ID: <1491383472-19477-5-git-send-email-Monk.Liu@amd.com>
References: <1491383472-19477-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491383472-19477-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJOWQxNzBmZjQ4OTNlOTgyYTk1NWYxOWE5MTc2NGNkZmVkNjE5YmM4NQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9teGdwdV9haS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbXhncHVfYWkuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmgK
aW5kZXggYTk4MTViNi4uOWFlZmM0NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbXhncHVfYWkuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9h
aS5oCkBAIC0yNCw3ICsyNCw3IEBACiAjaWZuZGVmIF9fTVhHUFVfQUlfSF9fCiAjZGVmaW5lIF9f
TVhHUFVfQUlfSF9fCiAKLSNkZWZpbmUgQUlfTUFJTEJPWF9USU1FRE9VVAkxNTAwMDAKKyNkZWZp
bmUgQUlfTUFJTEJPWF9USU1FRE9VVAk1MDAwCiAKIGVudW0gaWRoX3JlcXVlc3QgewogCUlESF9S
RVFfR1BVX0lOSVRfQUNDRVNTID0gMSwKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK

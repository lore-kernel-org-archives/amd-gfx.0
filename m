From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/virt: increase mailbox timeout value
Date: Thu, 19 Jan 2017 17:46:47 +0800
Message-ID: <1484819207-7722-1-git-send-email-Xiangliang.Yu@amd.com>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

SWYgc3RhcnQgYWxsIFZGcyBhdCBzYW1lIHRpbWUsIHRoZSBHUFUgaHlwZXJ2aXNvciBuZWVkIG1v
cmUgdGltZQp0byBoYW5kbGUgbWFpbGJveCBhY2Nlc3MuIFNldCBpdCB0byBmaXZlIHNlY29uZHMg
YWNjb3JkaW5nIHRvCnRlc3QgZXhwZXJpZW5jZS4KClNpZ25lZC1vZmYtYnk6IFhpYW5nbGlhbmcg
WXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV92aS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVf
dmkuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmgKaW5kZXggZmQ2MjE2
ZS4uMmRiNzQxMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVf
dmkuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5oCkBAIC0yMyw3
ICsyMyw3IEBACiAjaWZuZGVmIF9fTVhHUFVfVklfSF9fCiAjZGVmaW5lIF9fTVhHUFVfVklfSF9f
CiAKLSNkZWZpbmUgVklfTUFJTEJPWF9USU1FRE9VVAkxNTAKKyNkZWZpbmUgVklfTUFJTEJPWF9U
SU1FRE9VVAk1MDAwCiAjZGVmaW5lIFZJX01BSUxCT1hfUkVTRVRfVElNRQkxMgogCiAvKiBWSSBt
YWlsYm94IG1lc3NhZ2VzIHJlcXVlc3QgKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK

From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/23] drm/amdgpu/gfx8: correct KIQ hdp flush
Date: Sun, 18 Dec 2016 00:16:28 +0800
Message-ID: <1481991405-30422-7-git-send-email-Xiangliang.Yu@amd.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481991405-30422-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

S0lRIGhhcyBzb21lIGJlaGF2aW9yIGFzIGNvbXB1dGUgcmluZy4KClNpZ25lZC1vZmYtYnk6IFhp
YW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpp
bmRleCBhZTIwY2Q5Li5hNWE5YThlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8w
LmMKQEAgLTYxOTYsNyArNjE5Niw4IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3JpbmdfZW1pdF9o
ZHBfZmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogewogCXUzMiByZWZfYW5kX21hc2ss
IHJlZ19tZW1fZW5naW5lOwogCi0JaWYgKHJpbmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5H
X1RZUEVfQ09NUFVURSkgeworCWlmICgocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdf
VFlQRV9DT01QVVRFKSB8fAorCSAgICAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdf
VFlQRV9LSVEpKSB7CiAJCXN3aXRjaCAocmluZy0+bWUpIHsKIAkJY2FzZSAxOgogCQkJcmVmX2Fu
ZF9tYXNrID0gR1BVX0hEUF9GTFVTSF9ET05FX19DUDJfTUFTSyA8PCByaW5nLT5waXBlOwotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

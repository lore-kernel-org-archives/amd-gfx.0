From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amdgpu/virt: change AI ack-irq message to debug level
Date: Thu, 4 May 2017 14:37:21 +0800
Message-ID: <1493879841-27059-1-git-send-email-Xiangliang.Yu@amd.com>
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

Q2hhbmdlIG1lc3NhZ2UgdG8gZGVidWcgbGV2ZWwgYXMgVkkgZG9lcy4KClNpZ25lZC1vZmYtYnk6
IFhpYW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9teGdwdV9haS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbXhncHVfYWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMK
aW5kZXggZTk2N2E3Yi4uOTYxMzllYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbXhncHVfYWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9h
aS5jCkBAIC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIGludCB4Z3B1X2FpX21haWxib3hfYWNrX2ly
cShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJc3RydWN0IGFtZGdwdV9pcnFfc3Jj
ICpzb3VyY2UsCiAJCQkJCXN0cnVjdCBhbWRncHVfaXZfZW50cnkgKmVudHJ5KQogewotCXByaW50
aygiZ2V0IGFjayBpbnRyIGFuZCBkbyBub3RoaW5nLlxuIik7CisJRFJNX0RFQlVHKCJnZXQgYWNr
IGludHIgYW5kIGRvIG5vdGhpbmcuXG4iKTsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

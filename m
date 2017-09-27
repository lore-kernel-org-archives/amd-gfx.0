From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] amdgpu: don't ask about CHASH just default it for now.
Date: Thu, 28 Sep 2017 08:38:07 +1000
Message-ID: <20170927223807.460-1-airlied@gmail.com>
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

RnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KCklmIHdlIGJ1bXAgdGhpcyB1
cCBhIGxldmVsLCB3ZSBjYW4gYXNrIGFib3V0IGl0LCBmb3Igbm93LApqdXN0IGRlZmF1bHQgdG8g
d2hhdCBhbWRncHUgZG9lcy4KClNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJl
ZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9saWIvS2NvbmZpZyB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9saWIvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
bGliL0tjb25maWcKaW5kZXggMDNlZTdhZC4uNzc2ZWYzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9saWIvS2NvbmZpZworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2xpYi9LY29u
ZmlnCkBAIC00LDcgKzQsOCBAQCBtZW51ICJBTUQgTGlicmFyeSByb3V0aW5lcyIKICMgQ2xvc2Vk
IGhhc2ggdGFibGUKICMKIGNvbmZpZyBDSEFTSAotCXRyaXN0YXRlICJDbG9zZWQgaGFzaCB0YWJs
ZSIKKwl0cmlzdGF0ZQorCWRlZmF1bHQgRFJNX0FNREdQVQogCWhlbHAKIAkgU3RhdGljYWxseSBz
aXplZCBjbG9zZWQgaGFzaCB0YWJsZSBpbXBsZW1lbnRhdGlvbiB3aXRoIGxvdwogCSBtZW1vcnkg
YW5kIENQVSBvdmVyaGVhZC4KLS0gCjIuOS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK

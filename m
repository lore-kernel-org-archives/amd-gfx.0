From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/9] drm/amdgpu:keep bo pinned in prefered domain
Date: Wed, 28 Sep 2016 16:36:15 +0800
Message-ID: <1475051780-21634-4-git-send-email-Monk.Liu@amd.com>
References: <1475051780-21634-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475051780-21634-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KCkNoYW5nZS1JZDogSTg3ZmFlNjAy
YTIyNzc3NzE5MDJmNThmNjEwNjljMTg5MzA2MjcwMTIKU2lnbmVkLW9mZi1ieTogRnJhbmsgTWlu
IDxGcmFuay5NaW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY2dzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Nncy5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Nncy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nncy5j
Cm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKaW5kZXggYWIyZDdmYi4uN2Y3OTMyMwot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY2dzLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nncy5jCkBAIC0yNDAsNyArMjQwLDcgQEAgc3Rh
dGljIGludCBhbWRncHVfY2dzX2dtYXBfZ3B1X21lbShzdHJ1Y3QgY2dzX2RldmljZSAqY2dzX2Rl
dmljZSwgY2dzX2hhbmRsZV90IGgKIAlyID0gYW1kZ3B1X2JvX3Jlc2VydmUob2JqLCBmYWxzZSk7
CiAJaWYgKHVubGlrZWx5KHIgIT0gMCkpCiAJCXJldHVybiByOwotCXIgPSBhbWRncHVfYm9fcGlu
X3Jlc3RyaWN0ZWQob2JqLCBBTURHUFVfR0VNX0RPTUFJTl9HVFQsCisJciA9IGFtZGdwdV9ib19w
aW5fcmVzdHJpY3RlZChvYmosIG9iai0+cHJlZmVyZWRfZG9tYWlucywKIAkJCQkgICAgIG1pbl9v
ZmZzZXQsIG1heF9vZmZzZXQsIG1jYWRkcik7CiAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShvYmopOwog
CXJldHVybiByOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=

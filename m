From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/10] drm/amdgpu: init UMC & RSMU register base address
Date: Tue, 3 Sep 2019 00:02:16 +0000
Message-ID: <1567468894-11852-7-git-send-email-Hawking.Zhang@amd.com>
References: <1567468894-11852-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567468894-11852-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou1,
 Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

VU1DIFJBUyBmZWF0dXJlIHJlcXVpcmVzIGFjY2VzcyB0byBVTUMgJiBSU01VIHJlZ2lzdGVycwoK
U2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FyY3RfcmVnX2luaXQuYyB8IDIgKysKIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hcmN0X3JlZ19pbml0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
cmN0X3JlZ19pbml0LmMKaW5kZXggNDg1Mzg5OS4uZTYyNjA5ZCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYXJjdF9yZWdfaW5pdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FyY3RfcmVnX2luaXQuYwpAQCAtNTIsNiArNTIsOCBAQCBpbnQgYXJjdF9y
ZWdfYmFzZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhZGV2LT5yZWdfb2Zm
c2V0W1NETUE3X0hXSVBdW2ldID0gKHVpbnQzMl90ICopKCYoU0RNQTdfQkFTRS5pbnN0YW5jZVtp
XSkpOwogCQlhZGV2LT5yZWdfb2Zmc2V0W1NNVUlPX0hXSVBdW2ldID0gKHVpbnQzMl90ICopKCYo
U01VSU9fQkFTRS5pbnN0YW5jZVtpXSkpOwogCQlhZGV2LT5yZWdfb2Zmc2V0W1RITV9IV0lQXVtp
XSA9ICh1aW50MzJfdCAqKSgmKFRITV9CQVNFLmluc3RhbmNlW2ldKSk7CisJCWFkZXYtPnJlZ19v
ZmZzZXRbVU1DX0hXSVBdW2ldID0gKHVpbnQzMl90ICopKCYoVU1DX0JBU0UuaW5zdGFuY2VbaV0p
KTsKKwkJYWRldi0+cmVnX29mZnNldFtSU01VX0hXSVBdW2ldID0gKHVpbnQzMl90ICopKCYoUlNN
VV9CQVNFLmluc3RhbmNlW2ldKSk7CiAJfQogCXJldHVybiAwOwogfQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

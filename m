From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/madgpu: Fix EEPROM Checksum calculation.
Date: Wed, 4 Sep 2019 22:50:18 -0400
Message-ID: <1567651818-7911-3-git-send-email-andrey.grodzovsky@amd.com>
References: <1567651818-7911-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567651818-7911-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Guchun.Chen-5C7GfCeVMHo@public.gmane.org, Cristian.Saceleanu-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org, alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org

Rml4IHR5cG8gd2hpY2ggbWVzc2VkIHVwIHRoZSBjYWxjdWxhdGlvbi4KClNpZ25lZC1vZmYtYnk6
IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKaW5kZXggOGEzMmI1Yy4uNDNk
ZDRhYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJv
bS5jCkBAIC0yMjYsOCArMjI2LDggQEAgc3RhdGljIHZvaWQgX19kZWNvZGVfdGFibGVfcmVjb3Jk
X2Zyb21fYnVmZihzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY28KIAlyZWNvcmQt
Pm9mZnNldCA9IChsZTY0X3RvX2NwdSh0bXApICYgMHhmZmZmZmZmZmZmZmYpOwogCWkgKz0gNjsK
IAotCWJ1ZmZbaSsrXSA9IHJlY29yZC0+bWVtX2NoYW5uZWw7Ci0JYnVmZltpKytdID0gcmVjb3Jk
LT5tY3VtY19pZDsKKwlyZWNvcmQtPm1lbV9jaGFubmVsID0gYnVmZltpKytdOworCXJlY29yZC0+
bWN1bWNfaWQgPSBidWZmW2krK107CiAKIAltZW1jcHkoJnRtcCwgYnVmZiArIGksICA2KTsKIAly
ZWNvcmQtPnJldGlyZWRfcGFnZSA9IChsZTY0X3RvX2NwdSh0bXApICYgMHhmZmZmZmZmZmZmZmYp
OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

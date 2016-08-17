From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH 2/5] drm/amdgpu: fix amdgpu_move_blit on 32bit systems
Date: Wed, 17 Aug 2016 14:26:21 +0200
Message-ID: <1471436784-13252-2-git-send-email-deathsimple@vodafone.de>
References: <1471436784-13252-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471436784-13252-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhpcyBi
dWcgc2VlbXMgdG8gYmUgcHJlc2VudCBmb3IgYSB2ZXJ5IGxvbmcgdGltZS4KClNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDEwNWJkMjIuLmY1ZGM4N2UgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTI1Miw4ICsyNTIsOCBAQCBzdGF0aWMgaW50
IGFtZGdwdV9tb3ZlX2JsaXQoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAogCWFkZXYg
PSBhbWRncHVfZ2V0X2FkZXYoYm8tPmJkZXYpOwogCXJpbmcgPSBhZGV2LT5tbWFuLmJ1ZmZlcl9m
dW5jc19yaW5nOwotCW9sZF9zdGFydCA9IG9sZF9tZW0tPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7Ci0J
bmV3X3N0YXJ0ID0gbmV3X21lbS0+c3RhcnQgPDwgUEFHRV9TSElGVDsKKwlvbGRfc3RhcnQgPSAo
dTY0KW9sZF9tZW0tPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7CisJbmV3X3N0YXJ0ID0gKHU2NCluZXdf
bWVtLT5zdGFydCA8PCBQQUdFX1NISUZUOwogCiAJc3dpdGNoIChvbGRfbWVtLT5tZW1fdHlwZSkg
ewogCWNhc2UgVFRNX1BMX1ZSQU06Ci0tIAoyLjUuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

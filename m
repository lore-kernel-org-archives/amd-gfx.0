From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/31] drm/amd/display: i2c Remove link index.
Date: Fri, 12 May 2017 11:20:36 -0400
Message-ID: <20170512152104.5354-4-harry.wentland@amd.com>
References: <20170512152104.5354-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170512152104.5354-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+CgpIZWFk
ZXIgY2hhbmdlIGZvciBEQUwgY2hhbmdlIHVuZGVyIHNhbWUgbmFtZS4KClNpZ25lZC1vZmYtYnk6
IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9tb2RlLmgKaW5kZXggOTM2MmEwNGVhYTU5Li4wMTNlNzk2YjBhNDAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaApAQCAtNTY3LDggKzU2Nyw4
IEBAIHN0cnVjdCBhbWRncHVfZG1fZHBfYXV4IHsKIAogc3RydWN0IGFtZGdwdV9pMmNfYWRhcHRl
ciB7CiAJc3RydWN0IGkyY19hZGFwdGVyIGJhc2U7Ci0Jc3RydWN0IGFtZGdwdV9kaXNwbGF5X21h
bmFnZXIgKmRtOwotCXVpbnQzMl90IGxpbmtfaW5kZXg7CisKKwlzdHJ1Y3QgZGRjX3NlcnZpY2Ug
KmRkY19zZXJ2aWNlOwogfTsKIAogI2RlZmluZSBUT19ETV9BVVgoeCkgY29udGFpbmVyX29mKCh4
KSwgc3RydWN0IGFtZGdwdV9kbV9kcF9hdXgsIGF1eCkKLS0gCjIuMTEuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

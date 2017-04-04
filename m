From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] drm/amd/amdgpu: de-numberify HQD_ACTIVE check.
Date: Tue,  4 Apr 2017 10:03:43 -0400
Message-ID: <20170404140344.17441-4-tom.stdenis@amd.com>
References: <20170404140344.17441-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170404140344.17441-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMKaW5kZXggZDA5ZDY5YjBkMDk2Li40NmUyMzY3NDA1ZGUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtNDg4NCwxMCArNDg4NCwxMCBAQCBzdGF0
aWMgaW50IGdmeF92OF8wX2tpcV9pbml0X3JlZ2lzdGVyKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKIAlXUkVHMzIobW1DUF9IUURfUFFfRE9PUkJFTExfQ09OVFJPTCwgbXFkLT5jcF9ocWRfcHFf
ZG9vcmJlbGxfY29udHJvbCk7CiAKIAkvKiBkaXNhYmxlIHRoZSBxdWV1ZSBpZiBpdCdzIGFjdGl2
ZSAqLwotCWlmIChSUkVHMzIobW1DUF9IUURfQUNUSVZFKSAmIDEpIHsKKwlpZiAoUlJFRzMyKG1t
Q1BfSFFEX0FDVElWRSkgJiBDUF9IUURfQUNUSVZFX19BQ1RJVkVfTUFTSykgewogCQlXUkVHMzIo
bW1DUF9IUURfREVRVUVVRV9SRVFVRVNULCAxKTsKIAkJZm9yIChqID0gMDsgaiA8IGFkZXYtPnVz
ZWNfdGltZW91dDsgaisrKSB7Ci0JCQlpZiAoIShSUkVHMzIobW1DUF9IUURfQUNUSVZFKSAmIDEp
KQorCQkJaWYgKCEoUlJFRzMyKG1tQ1BfSFFEX0FDVElWRSkgJiBDUF9IUURfQUNUSVZFX19BQ1RJ
VkVfTUFTSykpCiAJCQkJYnJlYWs7CiAJCQl1ZGVsYXkoMSk7CiAJCX0KLS0gCjIuMTIuMAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

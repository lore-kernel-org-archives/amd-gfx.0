From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Fix offset for vmid selection in debugfs
 interface
Date: Tue, 16 Jul 2019 11:24:44 +0000
Message-ID: <20190716112434.29017-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

VGhlIHJlZ2lzdGVyIGRlYnVnZnMgaW50ZXJmYWNlIHdhcyB1c2luZyB0aGUgd3JvbmcgYml0bWFz
ayBmb3Igdm1pZApzZWxlY3Rpb24gZm9yIEdGWF9DTlRMLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0
IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
YnVnZnMuYwppbmRleCA4N2IzMjg3MzA0NmYuLjU5ODQ5ZWQ5Nzk3ZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCkBAIC0xMzIsNyArMTMyLDcgQEAgc3Rh
dGljIGludCAgYW1kZ3B1X2RlYnVnZnNfcHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3Qg
ZmlsZSAqZiwKIAkJbWUgPSAoKnBvcyAmIEdFTk1BU0tfVUxMKDMzLCAyNCkpID4+IDI0OwogCQlw
aXBlID0gKCpwb3MgJiBHRU5NQVNLX1VMTCg0MywgMzQpKSA+PiAzNDsKIAkJcXVldWUgPSAoKnBv
cyAmIEdFTk1BU0tfVUxMKDUzLCA0NCkpID4+IDQ0OwotCQl2bWlkID0gKCpwb3MgJiBHRU5NQVNL
X1VMTCg0OCwgNDUpKSA+PiA1NDsKKwkJdm1pZCA9ICgqcG9zICYgR0VOTUFTS19VTEwoNTgsIDU0
KSkgPj4gNTQ7CiAKIAkJdXNlX3JpbmcgPSAxOwogCX0gZWxzZSB7Ci0tIAoyLjIxLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

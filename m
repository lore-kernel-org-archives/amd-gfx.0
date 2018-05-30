From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/18] drm/amdgpu: add patch to jpeg ring
Date: Wed, 30 May 2018 16:27:26 -0400
Message-ID: <1527712053-15027-11-git-send-email-boyuan.zhang@amd.com>
References: <1527712053-15027-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527712053-15027-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBwYXRjaCBjb21t
YW5kcyB0byBqZXBnIHJpbmcgYnkgY2FsbGluZyBzZXQgcGF0Y2ggcmluZyBmdW5jdGlvbi4KCnYy
OiByZW1vdmUgbW9kaWZpY2F0aW9ucyBvbiBtYXhfZHcsIGJ1Zl9tYXNrIGFuZCBwdHJfbWFzaywg
c2luY2Ugd2UgYXJlCm5vdyB1c2luZyBleHRyYV9kdyBmb3IganBlZyByaW5nLgoKU2lnbmVkLW9m
Zi1ieTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKaW5kZXgg
NWFjNWZkNC4uZjZiZjVmNTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwpA
QCAtNzYwLDYgKzc2MCwxMyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3N0YXJ0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCVdSRUczMl9TT0MxNShVVkQsIDAsIG1tVVZEX0pSQkNfUkJfV1BU
UiwgMCk7CiAJV1JFRzMyX1NPQzE1KFVWRCwgMCwgbW1VVkRfSlJCQ19SQl9DTlRMLCAweDAwMDAw
MDAyTCk7CiAKKwkvKiBpbml0aWFsaXplIHdwdHIgKi8KKwlyaW5nLT53cHRyID0gUlJFRzMyX1NP
QzE1KFVWRCwgMCwgbW1VVkRfSlJCQ19SQl9XUFRSKTsKKworCS8qIGNvcHkgcGF0Y2ggY29tbWFu
ZHMgdG8gdGhlIGpwZWcgcmluZyAqLworCXZjbl92MV8wX2pwZWdfcmluZ19zZXRfcGF0Y2hfcmlu
ZyhyaW5nLAorCQkocmluZy0+d3B0ciArIHJpbmctPm1heF9kdyAqIGFtZGdwdV9zY2hlZF9od19z
dWJtaXNzaW9uKSk7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

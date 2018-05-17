From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] drm/amdgpu: Take vcn encode rings into account in idle
 work
Date: Thu, 17 May 2018 17:36:40 -0500
Message-ID: <20180517223640.23823-4-alexander.deucher@amd.com>
References: <20180517223640.23823-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180517223640.23823-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

VGFrZSB0aGUgZW5jb2RlIHJpbmdzIGludG8gYWNjb3VudCBpbiB0aGUgaWRsZSB3b3JrIGhhbmRs
ZXIuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgNSArKysr
KwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y24uYwppbmRleCBlNWQyMzRjZjgwNGYuLjYwNDY4Mzg1ZTZiNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpAQCAtMjA1LDYgKzIwNSwxMSBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yaykKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9CiAJCWNvbnRhaW5lcl9vZih3
b3JrLCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSwgdmNuLmlkbGVfd29yay53b3JrKTsKIAl1bnNpZ25l
ZCBmZW5jZXMgPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+dmNuLnJpbmdfZGVj
KTsKKwl1bnNpZ25lZCBpOworCisJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fZW5jX3Jp
bmdzOyArK2kpIHsKKwkJZmVuY2VzICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2
LT52Y24ucmluZ19lbmNbaV0pOworCX0KIAogCWlmIChmZW5jZXMgPT0gMCkgewogCQlpZiAoYWRl
di0+cG0uZHBtX2VuYWJsZWQpIHsKLS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

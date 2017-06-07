From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu/gfx9: remove spurious line in kiq setup
Date: Wed,  7 Jun 2017 15:34:53 -0400
Message-ID: <1496864097-4322-2-git-send-email-alexander.deucher@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

VGhpcyBvdmVycm9kZSB3aGF0IHF1ZXVlIHdhcyBhY3R1YWxseSBhc3NpZ25lZCBmb3Iga2lxLgoK
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxIC0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMK
aW5kZXggZTAxOTNlNC4uNGM0Nzc1NGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwpAQCAtMTA1NCw3ICsxMDU0LDYgQEAgc3RhdGljIGludCBnZnhfdjlfMF9raXFfaW5pdF9y
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChyKQogCQlyZXR1cm4gcjsKIAot
CXJpbmctPnF1ZXVlID0gMDsKIAlyaW5nLT5lb3BfZ3B1X2FkZHIgPSBraXEtPmVvcF9ncHVfYWRk
cjsKIAlzcHJpbnRmKHJpbmctPm5hbWUsICJraXEgJWQuJWQuJWQiLCByaW5nLT5tZSwgcmluZy0+
cGlwZSwgcmluZy0+cXVldWUpOwogCXIgPSBhbWRncHVfcmluZ19pbml0KGFkZXYsIHJpbmcsIDEw
MjQsCi0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

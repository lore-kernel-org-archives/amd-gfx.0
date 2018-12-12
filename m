From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdgpu/vcn:Always gate vcn block during hw finishing
Date: Wed, 12 Dec 2018 20:24:57 +0000
Message-ID: <1544646291-25293-1-git-send-email-James.Zhu@amd.com>
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
Cc: "jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

VW5kZXIgRHluYW1pYyBQb3dlciBHYXRlIG1vZGUsIFVWRF9TVEFUVVMgbmVlZG4ndCBiZSBjaGVj
a2VkLgoKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgMyArKy0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YxXzAuYwppbmRleCA0ZjgzNTIwLi43NzUyMDQzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92MV8wLmMKQEAgLTIxNCw3ICsyMTQsOCBAQCBzdGF0aWMgaW50IHZjbl92MV8w
X2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9
ICZhZGV2LT52Y24ucmluZ19kZWM7CiAKLQlpZiAoUlJFRzMyX1NPQzE1KFZDTiwgMCwgbW1VVkRf
U1RBVFVTKSkKKwlpZiAoKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRykg
fHwKKwkJUlJFRzMyX1NPQzE1KFZDTiwgMCwgbW1VVkRfU1RBVFVTKSkKIAkJdmNuX3YxXzBfc2V0
X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9QR19TVEFURV9HQVRFKTsKIAogCXJpbmctPnNj
aGVkLnJlYWR5ID0gZmFsc2U7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: use exiting amdgput_ctx_total_num_entities
 function
Date: Tue, 13 Aug 2019 09:08:21 +0000
Message-ID: <20190813090745.9496-2-kevin1.wang@amd.com>
References: <20190813090745.9496-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190813090745.9496-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
To: "dl.srdc_lnx_nv10" <dl.srdc_lnx_nv10-5C7GfCeVMHo@public.gmane.org>
Cc: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

c2ltcGxpZnkgZHJpdmVyIGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEu
d2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
YyB8IDUgKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKaW5kZXggOTVkODIwMWE3
MzhlLi44OWMyNmJiMGYwNWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4
LmMKQEAgLTI5MCwxMCArMjkwLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2N0eF9kb19yZWxlYXNl
KHN0cnVjdCBrcmVmICpyZWYpCiAKIAljdHggPSBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgYW1k
Z3B1X2N0eCwgcmVmY291bnQpOwogCi0JbnVtX2VudGl0aWVzID0gMDsKLQlmb3IgKGkgPSAwOyBp
IDwgQU1ER1BVX0hXX0lQX05VTTsgaSsrKQotCQludW1fZW50aXRpZXMgKz0gYW1kZ3B1X2N0eF9u
dW1fZW50aXRpZXNbaV07Ci0KKwludW1fZW50aXRpZXMgPSBhbWRncHVfY3R4X3RvdGFsX251bV9l
bnRpdGllcygpOwogCWZvciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykKIAkJZHJtX3Nj
aGVkX2VudGl0eV9kZXN0cm95KCZjdHgtPmVudGl0aWVzWzBdW2ldLmVudGl0eSk7CiAKLS0gCjIu
MjIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

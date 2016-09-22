From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_update param error
Date: Thu, 22 Sep 2016 11:41:06 +0800
Message-ID: <1474515666-24562-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODZkYzdkM2ZjNGQ2MTk3YmQxMzU2M2E0MjA3MThhODQxMmNlOWRiYwpTaWdu
ZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwppbmRleCA5NDE0MTZhLi5hN2VhOWEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jCkBAIC01MjgsNyArNTI4LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2dl
bV92YV91cGRhdGVfdm0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWdvdG8gZXJyb3Jf
dW5yZXNlcnZlOwogCiAJaWYgKG9wZXJhdGlvbiA9PSBBTURHUFVfVkFfT1BfTUFQKQotCQlyID0g
YW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192YSwgJmJvX3ZhLT5iby0+dGJvLm1lbSk7CisJ
CXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBmYWxzZSk7CiAKIGVycm9yX3Vu
cmVzZXJ2ZToKIAl0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7Ci0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

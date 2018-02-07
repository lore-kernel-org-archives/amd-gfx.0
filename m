From: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 8/9] drm/amdgpu: init mc base address for zfb
Date: Wed, 7 Feb 2018 20:34:51 +0800
Message-ID: <1518006892-14121-9-git-send-email-Feifei.Xu@amd.com>
References: <1518006892-14121-1-git-send-email-Feifei.Xu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518006892-14121-1-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
ODliOWZmMzZiNjJlYjY4NWE5ZTJkODdlMjA1OGQyMDBiOTJmNTAzNApTaWduZWQtb2ZmLWJ5OiBI
YXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkFja2VkLWJ5OiBKb2huIEJyaWRn
bWFuIDxqb2huLmJyaWRnbWFuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjFfMC5jIHwgOSArKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbW1odWJfdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5j
CmluZGV4IGI1MzlmZDEuLmM1NmFiNDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3YxXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1
Yl92MV8wLmMKQEAgLTM4LDkgKzM4LDEyIEBACiB1NjQgbW1odWJfdjFfMF9nZXRfZmJfbG9jYXRp
b24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJdTY0IGJhc2UgPSBSUkVHMzJfU09D
MTUoTU1IVUIsIDAsIG1tTUNfVk1fRkJfTE9DQVRJT05fQkFTRSk7Ci0KLQliYXNlICY9IE1DX1ZN
X0ZCX0xPQ0FUSU9OX0JBU0VfX0ZCX0JBU0VfTUFTSzsKLQliYXNlIDw8PSAyNDsKKwlpZiAoYWRl
di0+Z21jLmVuYWJsZV96ZmIpIHsKKwkJYmFzZSA9IDB4RjQwMDAwMDAwMFVMTDsKKwl9IGVsc2Ug
eworCQliYXNlICY9IE1DX1ZNX0ZCX0xPQ0FUSU9OX0JBU0VfX0ZCX0JBU0VfTUFTSzsKKwkJYmFz
ZSA8PD0gMjQ7CisJfQogCiAJcmV0dXJuIGJhc2U7CiB9Ci0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

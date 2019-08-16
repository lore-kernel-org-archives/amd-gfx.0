From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: add smu_smc_read_sensor support for
 arcturus
Date: Fri, 16 Aug 2019 07:22:20 +0000
Message-ID: <20190816072200.21833-1-kevin1.wang@amd.com>
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
Cc: "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>

dGhlIGJlbGxvdyBwYXRjaCByZWZpbmUgdGhlIHNlbnNvciByZWFkIHNlcXVlbmNlLApidXQgbWlz
c2VkIHRvIGFkZCBhcmN1dHVycyBzdXBwb3J0LiAoYXJjdXR1cnNfcHB0LmMpCgpkcm0vYW1kL3Bv
d2VycGxheTogY2hhbmdlIHNtdV9yZWFkX3NlbnNvciBzZXF1ZW5jZSBpbiBzbXUKClNpZ25lZC1v
ZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwppbmRleCBmY2Y2MjNjZjVkMmMuLjg1MGIyYTFlZjMy
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKQEAg
LTEwMTIsNiArMTAxMiw5IEBAIHN0YXRpYyBpbnQgYXJjdHVydXNfcmVhZF9zZW5zb3Ioc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUsCiAJUFBUYWJsZV90ICpwcHRhYmxlID0gdGFibGVfY29udGV4dC0+
ZHJpdmVyX3BwdGFibGU7CiAJaW50IHJldCA9IDA7CiAKKwlpZighZGF0YSB8fCAhc2l6ZSkKKwkJ
cmV0dXJuIC1FSU5WQUw7CisKIAlzd2l0Y2ggKHNlbnNvcikgewogCWNhc2UgQU1ER1BVX1BQX1NF
TlNPUl9NQVhfRkFOX1JQTToKIAkJKih1aW50MzJfdCAqKWRhdGEgPSBwcHRhYmxlLT5GYW5NYXhp
bXVtUnBtOwpAQCAtMTAzNiw3ICsxMDM5LDcgQEAgc3RhdGljIGludCBhcmN0dXJ1c19yZWFkX3Nl
bnNvcihzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKIAkJKnNpemUgPSA0OwogCQlicmVhazsKIAlk
ZWZhdWx0OgotCQlyZXR1cm4gLUVJTlZBTDsKKwkJcmV0ID0gc211X3NtY19yZWFkX3NlbnNvcihz
bXUsIHNlbnNvciwgZGF0YSwgc2l6ZSk7CiAJfQogCiAJcmV0dXJuIHJldDsKLS0gCjIuMjIuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

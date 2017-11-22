From: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/ttm: free one in huge pool even shrink request less
 than one element
Date: Wed, 22 Nov 2017 13:36:56 +0800
Message-ID: <1511329016-552-4-git-send-email-Hongbo.He@amd.com>
References: <1511329016-552-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511329016-552-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJZDhiZDRkMWVjZmY5ZjNhYjE0MzU1ZTJkYmQxYzU5YjlmZTgyNGUwMQpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxv
Yy5jCmluZGV4IDM3YzJmMmYuLmY4MGZjNWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2Fs
bG9jLmMKQEAgLTQ2MywxMSArNDYzLDEzIEBAIHR0bV9wb29sX3Nocmlua19zY2FuKHN0cnVjdCBz
aHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hyaW5rX2NvbnRyb2wgKnNjKQogCQlwb29sID0gJl9t
YW5hZ2VyLT5wb29sc1soaSArIHBvb2xfb2Zmc2V0KSVOVU1fUE9PTFNdOwogCQkvKiBPSyB0byB1
c2Ugc3RhdGljIGJ1ZmZlciBzaW5jZSBnbG9iYWwgbXV0ZXggaXMgaGVsZC4gKi8KIAkJbnJfZnJl
ZV9wb29sID0gKG5yX2ZyZWUgPj4gcG9vbC0+b3JkZXIpOwotCQlpZiAobnJfZnJlZV9wb29sID09
IDApCi0JCQljb250aW51ZTsKKwkJaWYgKCFucl9mcmVlX3Bvb2wgJiYgcG9vbC0+b3JkZXIpCisJ
CQlucl9mcmVlX3Bvb2wgPSAxOwogCiAJCXNocmlua19wYWdlcyA9IHR0bV9wYWdlX3Bvb2xfZnJl
ZShwb29sLCBucl9mcmVlX3Bvb2wsIHRydWUpOwogCQlmcmVlZCArPSAoKG5yX2ZyZWVfcG9vbCAt
IHNocmlua19wYWdlcykgPDwgcG9vbC0+b3JkZXIpOworCQlpZiAoZnJlZWQgPj0gc2MtPm5yX3Rv
X3NjYW4pCisJCQlicmVhazsKIAl9CiAJbXV0ZXhfdW5sb2NrKCZsb2NrKTsKIAlyZXR1cm4gZnJl
ZWQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

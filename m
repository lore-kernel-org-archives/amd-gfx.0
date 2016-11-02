From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/7] drm/amd/powerplay: fix code style
Date: Wed, 2 Nov 2016 18:27:39 +0800
Message-ID: <1478082461-23495-6-git-send-email-Rex.Zhu@amd.com>
References: <1478082461-23495-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478082461-23495-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZGYzMDI5ZGQ2MTQ2OWM1NDRjODQzMWJhMjIyMGY2MWEyMWY5ODU0OQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19wb3dlcnR1bmUuYyB8IDUgKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19wb3dlcnR1bmUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfcG93ZXJ0dW5lLmMKaW5kZXggNDFi
NjM0Zi4uMjY0NzdmMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3Ivc211N19wb3dlcnR1bmUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci9zbXU3X3Bvd2VydHVuZS5jCkBAIC02MDMsOSArNjAzLDEwIEBAIGludCBzbXU3X3Nl
dF9wb3dlcl9saW1pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJfdCBuKQogCXJldHVy
biAwOwogfQogCi1zdGF0aWMgaW50IHNtdTdfc2V0X292ZXJkcml2ZXJfdGFyZ2V0X3RkcChzdHJ1
Y3QgcHBfaHdtZ3IgKnBId01nciwgdWludDMyX3QgdGFyZ2V0X3RkcCkKK3N0YXRpYyBpbnQgc211
N19zZXRfb3ZlcmRyaXZlcl90YXJnZXRfdGRwKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCisJCQkJ
CQl1aW50MzJfdCB0YXJnZXRfdGRwKQogewotCXJldHVybiBzbXVtX3NlbmRfbXNnX3RvX3NtY193
aXRoX3BhcmFtZXRlcihwSHdNZ3ItPnNtdW1nciwKKwlyZXR1cm4gc211bV9zZW5kX21zZ190b19z
bWNfd2l0aF9wYXJhbWV0ZXIoaHdtZ3ItPnNtdW1nciwKIAkJCVBQU01DX01TR19PdmVyRHJpdmVT
ZXRUYXJnZXRUZHAsIHRhcmdldF90ZHApOwogfQogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

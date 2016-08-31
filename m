From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/10] drm/radeon: handle runtime pm in drm pre/post close
Date: Wed, 31 Aug 2016 18:08:52 -0400
Message-ID: <1472681336-30106-6-git-send-email-alexander.deucher@amd.com>
References: <1472681336-30106-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472681336-30106-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

Q2xvc2Ugd2FzIG5vdCBoYW5kbGVkIGNvcnJlY3RseS4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9rbXMuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKaW5kZXggODM1NTYzYy4uMDI1MjUyNyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKQEAgLTcxNyw2ICs3MTcsOCBAQCB2b2lk
IHJhZGVvbl9kcml2ZXJfcG9zdGNsb3NlX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAogCQlr
ZnJlZShmcHJpdik7CiAJCWZpbGVfcHJpdi0+ZHJpdmVyX3ByaXYgPSBOVUxMOwogCX0KKwlwbV9y
dW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+ZGV2KTsKKwlwbV9ydW50aW1lX3B1dF9hdXRvc3Vz
cGVuZChkZXYtPmRldik7CiB9CiAKIC8qKgpAQCAtNzMzLDYgKzczNSw4IEBAIHZvaWQgcmFkZW9u
X2RyaXZlcl9wcmVjbG9zZV9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIHsKIAlzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CiAKKwlwbV9ydW50aW1lX2dl
dF9zeW5jKGRldi0+ZGV2KTsKKwogCW11dGV4X2xvY2soJnJkZXYtPmdlbS5tdXRleCk7CiAJaWYg
KHJkZXYtPmh5cGVyel9maWxwID09IGZpbGVfcHJpdikKIAkJcmRldi0+aHlwZXJ6X2ZpbHAgPSBO
VUxMOwotLSAKMi41LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

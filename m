From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: check domain sanity in
 amdgpu_bo_pin_restricted()
Date: Thu, 18 Aug 2016 13:36:57 +0800
Message-ID: <1471498619-7497-1-git-send-email-Flora.Cui@amd.com>
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

YWJvcnQgaWYgdGhlIGJvIGlzIHBpbmVkIHRvIG90aGVyIGRvbWFpbiBhbHJlYWR5CgpDaGFuZ2Ut
SWQ6IEkwZThlYjNlMGFmMGZhZDFlZGFmNjQ3MDUwMzk5ZTVhMzYyMjZhNWQ5ClNpZ25lZC1vZmYt
Ynk6IEZsb3JhIEN1aSA8RmxvcmEuQ3VpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpp
bmRleCA0ZDA4NGVlLi4wYTBmM2NiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jCkBAIC01MjAsNiArNTIwLDExIEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3Ry
aWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21haW4sCiAJCXJldHVybiAtRUlOVkFM
OwogCiAJaWYgKGJvLT5waW5fY291bnQpIHsKKwkJdWludDMyX3QgbWVtX3R5cGUgPSBiby0+dGJv
Lm1lbS5tZW1fdHlwZTsKKworCQlpZiAoZG9tYWluICE9IGFtZGdwdV9tZW1fdHlwZV90b19kb21h
aW4obWVtX3R5cGUpKQorCQkJcmV0dXJuIC1FSU5WQUw7CisKIAkJYm8tPnBpbl9jb3VudCsrOwog
CQlpZiAoZ3B1X2FkZHIpCiAJCQkqZ3B1X2FkZHIgPSBhbWRncHVfYm9fZ3B1X29mZnNldChibyk7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

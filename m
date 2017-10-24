From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: fix indentation in amdgpu_display.h
Date: Tue, 24 Oct 2017 16:37:41 +0200
Message-ID: <1508855862-1817-4-git-send-email-deathsimple@vodafone.de>
References: <1508855862-1817-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508855862-1817-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: harry.wentland-5C7GfCeVMHo@public.gmane.org, Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhhdCB3
YXMgc29tZWhvdyBjb21wbGV0ZWx5IG9mLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmggfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzcGxheS5oCmluZGV4IDNjYzBlZjAuLjExYWU0YWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmgKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuaApAQCAtMjUsOSArMjUsOCBAQAogCiBzdHJ1Y3Qg
ZHJtX2ZyYW1lYnVmZmVyICoKIGFtZGdwdV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2LAotCQkJCQkJICAgICAgIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2
LAotCQkJCQkJCSAgIGNvbnN0IHN0cnVjdCBkcm1fbW9kZV9mYl9jbWQyICptb2RlX2NtZCk7Ci0K
KwkJCSAgICAgICBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdiwKKwkJCSAgICAgICBjb25zdCBz
dHJ1Y3QgZHJtX21vZGVfZmJfY21kMiAqbW9kZV9jbWQpOwogdm9pZCBhbWRncHVfb3V0cHV0X3Bv
bGxfY2hhbmdlZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KTsKIAogI2VuZGlmCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

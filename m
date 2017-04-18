From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu/mmhub_v1: bypass clockgating setting
Date: Tue, 18 Apr 2017 15:38:13 +0800
Message-ID: <1492501093-26948-1-git-send-email-Xiangliang.Yu@amd.com>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

Rm9yIFNSSU9WIGRvZXNuJ3QgbmVlZCBDRywgc28gYnlwYXNzIGl0LgoKU2lnbmVkLW9mZi1ieTog
WGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3YxXzAuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJf
djFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5jCmluZGV4IDYy
Njg0NTEuLmRiZmU0OGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21t
aHViX3YxXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMK
QEAgLTUxMSw2ICs1MTEsOSBAQCBzdGF0aWMgaW50IG1taHViX3YxXzBfc2V0X2Nsb2NrZ2F0aW5n
X3N0YXRlKHZvaWQgKmhhbmRsZSwKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAorCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpCisJCXJldHVybiAwOworCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENI
SVBfVkVHQTEwOgogCQltbWh1Yl92MV8wX3VwZGF0ZV9tZWRpdW1fZ3JhaW5fY2xvY2tfZ2F0aW5n
KGFkZXYsCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==

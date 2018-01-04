From: Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: fix not to add amdgpu.ids when building
 without amdgpu
Date: Thu, 04 Jan 2018 15:31:51 +0900
Message-ID: <1515047511-22663-1-git-send-email-sw0312.kim@samsung.com>
References: <CGME20180104063136epcas2p3452c49068b47e2324ebff56845c164f3@epcas2p3.samsung.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org

VGhlIGFtZGdwdS5pZHMgaXMgb25seSByZXF1aXJlZCB3aGVuIGJ1aWxkaW5nIHdpdGggYW1kZ3B1
IHN1cHBvcnQuCkZpeCBub3QgdG8gYWRkIGl0IHdpdGhvdXQgYW1kZ3B1LgoKU2lnbmVkLW9mZi1i
eTogU2V1bmctV29vIEtpbSA8c3cwMzEyLmtpbUBzYW1zdW5nLmNvbT4KLS0tCiBkYXRhL01ha2Vm
aWxlLmFtIHwgICAgMiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGF0YS9NYWtlZmlsZS5hbSBiL2RhdGEvTWFrZWZpbGUu
YW0KaW5kZXggZWJhOTE1ZC4uODk3YTdmMyAxMDA2NDQKLS0tIGEvZGF0YS9NYWtlZmlsZS5hbQor
KysgYi9kYXRhL01ha2VmaWxlLmFtCkBAIC0yMCw0ICsyMCw2IEBACiAjICBDT05ORUNUSU9OIFdJ
VEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRX
QVJFLgogCiBsaWJkcm1kYXRhZGlyID0gQGxpYmRybWRhdGFkaXJACitpZiBIQVZFX0FNREdQVQog
ZGlzdF9saWJkcm1kYXRhX0RBVEEgPSBhbWRncHUuaWRzCitlbmRpZgotLSAKMS43LjQuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: likun Gao <likun.gao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: Disable deadlock test suite for RV/RV2/PCO
Date: Tue, 14 Aug 2018 19:10:10 +0800
Message-ID: <1534245010-17995-1-git-send-email-likun.gao@amd.com>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KCmRpc2FibGUgZGVhZGxvY2sgdGVz
dCBzdWl0ZSBmb3IgUlYvUlYyL1BDTwoKU2lnbmVkLW9mZi1ieTogTGlrdW4gR2FvIDxMaWt1bi5H
YW9AYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvZGVhZGxvY2tfdGVzdHMuYyB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdHMvYW1kZ3B1L2RlYWRsb2NrX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUvZGVhZGxvY2tf
dGVzdHMuYwppbmRleCAxZWI1NzYxLi4zMDQ0ODJkIDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUv
ZGVhZGxvY2tfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvZGVhZGxvY2tfdGVzdHMuYwpAQCAt
OTMsNyArOTMsOCBAQCBDVV9CT09MIHN1aXRlX2RlYWRsb2NrX3Rlc3RzX2VuYWJsZSh2b2lkKQog
CQlyZXR1cm4gQ1VfRkFMU0U7CiAKIAlpZiAoZGV2aWNlX2hhbmRsZS0+aW5mby5mYW1pbHlfaWQg
PT0gQU1ER1BVX0ZBTUlMWV9BSSB8fAotCSAgICBkZXZpY2VfaGFuZGxlLT5pbmZvLmZhbWlseV9p
ZCA9PSBBTURHUFVfRkFNSUxZX1NJKSB7CisJICAgIGRldmljZV9oYW5kbGUtPmluZm8uZmFtaWx5
X2lkID09IEFNREdQVV9GQU1JTFlfU0kgfHwKKwkgICAgZGV2aWNlX2hhbmRsZS0+aW5mby5mYW1p
bHlfaWQgPT0gQU1ER1BVX0ZBTUlMWV9SVikgewogCQlwcmludGYoIlxuXG5DdXJyZW50bHkgaGFu
Z3MgdGhlIENQIG9uIHRoaXMgQVNJQywgZGVhZGxvY2sgc3VpdGUgZGlzYWJsZWRcbiIpOwogCQll
bmFibGUgPSBDVV9GQUxTRTsKIAl9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

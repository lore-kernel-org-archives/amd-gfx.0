From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu:Preamble is forbid to be ignored in SRIOV
Date: Wed, 18 Jan 2017 10:40:32 +0800
Message-ID: <1484707233-29838-3-git-send-email-Monk.Liu@amd.com>
References: <1484707233-29838-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484707233-29838-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNmRhOTQxZmEyMmNmYWVlNDNkNmRjMTExOTFiMWZiNzQ4MmU3MzYyYgpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aWIuYwppbmRleCBiY2Q1MTQyLi43NTUyMzI2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYwpAQCAtMTkzLDcgKzE5Myw4IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBudW1faWJzLAogCQkvKiBkcm9wIHByZWFt
YmxlIElCcyBpZiB3ZSBkb24ndCBoYXZlIGEgY29udGV4dCBzd2l0Y2ggKi8KIAkJaWYgKChpYi0+
ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19QUkVBTUJMRSkgJiYKIAkJCXNraXBfcHJlYW1ibGUgJiYK
LQkJCSEoc3RhdHVzICYgQU1ER1BVX1BSRUFNQkxFX0lCX1BSRVNFTlRfRklSU1QpKQorCQkJIShz
dGF0dXMgJiBBTURHUFVfUFJFQU1CTEVfSUJfUFJFU0VOVF9GSVJTVCkgJiYKKwkJCSFhbWRncHVf
c3Jpb3ZfdmYoYWRldikpIC8qIGZvciBTUklPViBwcmVlbXB0aW9uLCBQcmVhbWJsZSBDRSBpYiBt
dXN0IGJlIGluc2VydGVkIGFueXdheSAqLwogCQkJY29udGludWU7CiAKIAkJYW1kZ3B1X3Jpbmdf
ZW1pdF9pYihyaW5nLCBpYiwgam9iID8gam9iLT52bV9pZCA6IDAsCi0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

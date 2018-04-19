From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/pp: Fix NULL point check error in
 smu_set_watermarks_for_clocks_ranges
Date: Thu, 19 Apr 2018 12:47:47 +0800
Message-ID: <1524113267-23610-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

SXQgaXMgY2F1c2VkIGJ5Cidjb21taXQgZDZjOWE3ZGM4NmNkICgiZHJtL2FtZC9wcDogTW92ZSBj
b21tb24gY29kZSB0byBzbXVfaGVscGVyLmMiKScKClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJl
eC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9z
bXVfaGVscGVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21n
ci9zbXVfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXVf
aGVscGVyLmMKaW5kZXggN2MyMzc0MS4uOTNhM2QwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211X2hlbHBlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYwpAQCAtNjU3LDcgKzY1Nyw3IEBAIGlu
dCBzbXVfc2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nrc19yYW5nZXModm9pZCAqd3RfdGFibGUsCiAJ
dWludDMyX3QgaTsKIAlzdHJ1Y3Qgd2F0ZXJtYXJrcyAqdGFibGUgPSB3dF90YWJsZTsKIAotCWlm
ICghdGFibGUgfHwgd21fd2l0aF9jbG9ja19yYW5nZXMpCisJaWYgKCF0YWJsZSB8fCAhd21fd2l0
aF9jbG9ja19yYW5nZXMpCiAJCXJldHVybiAtRUlOVkFMOwogCiAJaWYgKHdtX3dpdGhfY2xvY2tf
cmFuZ2VzLT5udW1fd21fc2V0c19kbWlmID4gNCB8fCB3bV93aXRoX2Nsb2NrX3Jhbmdlcy0+bnVt
X3dtX3NldHNfbWNpZiA+IDQpCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==

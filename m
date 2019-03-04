From: likun Gao <likun.gao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix pcie sysfs interface when set wrong
 value
Date: Mon, 4 Mar 2019 11:47:49 +0800
Message-ID: <1551671269-30697-1-git-send-email-likun.gao@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Huang Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Gui Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KClRoZSBvcGVyYXRpb24gb2YgbXV0
ZXhfdW5sb2NrIHNtdS0+bXV0ZXggc2hvdWxkIGJlIGRvbmUgd2hlbiBmb3JjZWQgbGV2ZWwgaXMg
bGFyZ2VyIHRoYW4gTlVNX0xJTktfTEVWRUxTIGluIHRoZSBmdW5jdGlvbiBvZiBmb3JjZV9jbGtf
bGV2ZWxzLgoKUmVwb3J0ZWQtYnk6IEp1bGlhIExhd2FsbCA8anVsaWEubGF3YWxsQGxpcDYuZnI+
ClNpZ25lZC1vZmYtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jIHwgNiArKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jCmluZGV4IGY3MTg4YTcuLjRiMWZjNDUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3ZlZ2EyMF9wcHQuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMKQEAgLTEyMDYsOCArMTIw
NiwxMCBAQCBzdGF0aWMgaW50IHZlZ2EyMF9mb3JjZV9jbGtfbGV2ZWxzKHN0cnVjdCBzbXVfY29u
dGV4dCAqc211LAogCiAJY2FzZSBQUF9QQ0lFOgogCQlpZiAoc29mdF9taW5fbGV2ZWwgPj0gTlVN
X0xJTktfTEVWRUxTIHx8Ci0JCSAgICBzb2Z0X21heF9sZXZlbCA+PSBOVU1fTElOS19MRVZFTFMp
Ci0JCQlyZXR1cm4gLUVJTlZBTDsKKwkJICAgIHNvZnRfbWF4X2xldmVsID49IE5VTV9MSU5LX0xF
VkVMUykgeworCQkJcmV0ID0gLUVJTlZBTDsKKwkJCWJyZWFrOworCQl9CiAKIAkJcmV0ID0gc211
X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwKIAkJCQlTTVVfTVNHX1NldE1pbkxpbmtEcG1C
eUluZGV4LCBzb2Z0X21pbl9sZXZlbCk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4

From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu/gfx: free memory of mqd backup
Date: Thu, 16 Feb 2017 15:25:20 +0800
Message-ID: <1487229920-4897-3-git-send-email-Xiangliang.Yu@amd.com>
References: <1487229920-4897-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487229920-4897-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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

TmVlZCB0byBmcmVlIG1xZCBiYWNrdXAgd2hlbiBkZXN0cm95aW5nIHJpbmcuCgpTaWduZWQtb2Zm
LWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwppbmRleCAyMjAy
ZjAyLi4yM2NmNmZhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKQEAgLTcz
NzksMTIgKzczNzksMTQgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfY29tcHV0ZV9tcWRfc29mdF9m
aW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJZm9yIChpID0gMDsgaSA8IGFkZXYt
PmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7CiAJCXJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1
dGVfcmluZ1tpXTsKKwkJa2ZyZWUoYWRldi0+Z2Z4Lm1lYy5tcWRfYmFja3VwW2ldKTsKIAkJYW1k
Z3B1X2JvX2ZyZWVfa2VybmVsKCZyaW5nLT5tcWRfb2JqLAogCQkJCSAgICAgICZyaW5nLT5tcWRf
Z3B1X2FkZHIsCiAJCQkJICAgICAgJnJpbmctPm1xZF9wdHIpOwogCX0KIAogCXJpbmcgPSAmYWRl
di0+Z2Z4LmtpcS5yaW5nOworCWtmcmVlKGFkZXYtPmdmeC5tZWMubXFkX2JhY2t1cFtBTURHUFVf
TUFYX0NPTVBVVEVfUklOR1NdKTsKIAlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJnJpbmctPm1xZF9v
YmosCiAJCQkgICAgICAmcmluZy0+bXFkX2dwdV9hZGRyLAogCQkJICAgICAgJnJpbmctPm1xZF9w
dHIpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

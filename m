From: HaiJun Chang <HaiJun.Chang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi
Date: Tue, 29 Oct 2019 17:18:13 +0800
Message-ID: <1572340693-122958-1-git-send-email-HaiJun.Chang@amd.com>
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
Cc: HaiJun Chang <HaiJun.Chang-5C7GfCeVMHo@public.gmane.org>

Q3Agd3B0ciBpbiB3YiBidWZmZXIgaXMgb3V0ZGF0ZWQgYWZ0ZXIgVkYgRkxSLgpUaGUgb3V0ZGF0
ZWQgd3B0ciBtYXkgY2F1c2UgY3AgdG8gZXhlY3V0ZSB1bmV4cGVjdGVkIHBhY2tldHMuClJlc2V0
IGNwIHdwdHIgaW4gd2IgYnVmZmVyLgoKU2lnbmVkLW9mZi1ieTogSGFpSnVuIENoYW5nIDxIYWlK
dW4uQ2hhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCBkMTI2ZDY2Li4xMzM2M2YyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtMzEwNyw2ICszMTA3LDcgQEAgc3RhdGlj
IGludCBnZnhfdjEwXzBfZ2Z4X2luaXRfcXVldWUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQog
CQkJbWVtY3B5KG1xZCwgYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbQU1ER1BVX01BWF9HRlhfUklO
R1NdLCBzaXplb2YoKm1xZCkpOwogCQkvKiByZXNldCB0aGUgcmluZyAqLwogCQlyaW5nLT53cHRy
ID0gMDsKKwkJYWRldi0+d2Iud2JbcmluZy0+d3B0cl9vZmZzXSA9IDA7CiAJCWFtZGdwdV9yaW5n
X2NsZWFyX3JpbmcocmluZyk7CiAjaWZkZWYgQlJJTkdfVVBfREVCVUcKIAkJbXV0ZXhfbG9jaygm
YWRldi0+c3JibV9tdXRleCk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4

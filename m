From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: fix compiler warning.
Date: Thu, 8 Sep 2016 14:05:16 +0800
Message-ID: <1473314717-28780-2-git-send-email-Rex.Zhu@amd.com>
References: <1473314717-28780-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473314717-28780-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

bm8gcGFyZW50aGVzZXMgYXJvdW5kIGFzc2lnbm1lbnQgdXNlZCBhcyB0cnV0aCB2YWx1ZS4KCkNo
YW5nZS1JZDogSTZiYzRiNzRkMzgzOGE0ZDBjNGM3YTFiNDZjNzRhNWQ0MDVlNzZmNGUKU2lnbmVk
LW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCmluZGV4IGYxN2ZjNmQuLmQ0OTdjMTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTE5NzcsNyArMTk3Nyw4IEBAIGludCBhbWRn
cHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHJlc3VtZSwgYm9v
bCBmYmNvbikKIAlpZiAocmVzdW1lKSB7CiAJCXBjaV9zZXRfcG93ZXJfc3RhdGUoZGV2LT5wZGV2
LCBQQ0lfRDApOwogCQlwY2lfcmVzdG9yZV9zdGF0ZShkZXYtPnBkZXYpOwotCQlpZiAociA9IHBj
aV9lbmFibGVfZGV2aWNlKGRldi0+cGRldikpIHsKKwkJciA9IHBjaV9lbmFibGVfZGV2aWNlKGRl
di0+cGRldik7CisJCWlmIChyICE9IDApIHsKIAkJCWlmIChmYmNvbikKIAkJCQljb25zb2xlX3Vu
bG9jaygpOwogCQkJcmV0dXJuIHI7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==

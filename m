From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/11] drm/amd: add recover run queue for scheduler
Date: Thu, 28 Jul 2016 18:13:40 +0800
Message-ID: <1469700828-25650-4-git-send-email-David1.Zhou@amd.com>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzE3MWQxZTM4ODRhYWJlMTI2M2Q4ZjdiZTE4Y2FkZjJlOTgyMTZhNApTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuaCB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oCmluZGV4IGExYzAwNzMuLmNkODdiYzcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmgKQEAg
LTExMiw3ICsxMTIsOCBAQCBzdHJ1Y3QgYW1kX3NjaGVkX2JhY2tlbmRfb3BzIHsKIH07CiAKIGVu
dW0gYW1kX3NjaGVkX3ByaW9yaXR5IHsKLQlBTURfU0NIRURfUFJJT1JJVFlfS0VSTkVMID0gMCwK
KwlBTURfU0NIRURfUFJJT1JJVFlfUkVDT1ZFUiA9IDAsCisJQU1EX1NDSEVEX1BSSU9SSVRZX0tF
Uk5FTCwKIAlBTURfU0NIRURfUFJJT1JJVFlfTk9STUFMLAogCUFNRF9TQ0hFRF9NQVhfUFJJT1JJ
VFkKIH07Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==

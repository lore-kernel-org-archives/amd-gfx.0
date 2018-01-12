From: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu: only set dma_buf ops when it is valid
Date: Fri, 12 Jan 2018 18:01:51 -0500
Message-ID: <1515798111-28959-1-git-send-email-Samuel.Li@amd.com>
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
Cc: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMzdkYWVjYmY2OTVkYTEzZWFlZWExZDM2MmMyNzBiOTJhODk0MzkzYQotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jIHwgNSArKystLQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJpbWUuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jCmluZGV4IGExNDIzNGIuLjhhZmVjMjEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmltZS5jCkBAIC0yMjEsOSArMjIx
LDEwIEBAIHN0cnVjdCBkbWFfYnVmICphbWRncHVfZ2VtX3ByaW1lX2V4cG9ydChzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LAogCQlyZXR1cm4gRVJSX1BUUigtRVBFUk0pOwogCiAJYnVmID0gZHJtX2dl
bV9wcmltZV9leHBvcnQoZGV2LCBnb2JqLCBmbGFncyk7Ci0JaWYgKCFJU19FUlIoYnVmKSkKKwlp
ZiAoIUlTX0VSUihidWYpKSB7CiAJCWJ1Zi0+ZmlsZS0+Zl9tYXBwaW5nID0gZGV2LT5hbm9uX2lu
b2RlLT5pX21hcHBpbmc7Ci0JYnVmLT5vcHMgPSAmYW1kZ3B1X2RtYWJ1Zl9vcHM7CisJCWJ1Zi0+
b3BzID0gJmFtZGdwdV9kbWFidWZfb3BzOworCX0KIAogCXJldHVybiBidWY7CiB9Ci0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/12] drm/ttm: Fix indentation in
 ttm_dma_pool_alloc_new_pages()
Date: Fri, 26 Jan 2018 13:29:07 -0500
Message-ID: <20180126182911.20761-9-tom.stdenis@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126182911.20761-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMgfCAzICstLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9wYWdlX2FsbG9jX2RtYS5jCmluZGV4IDU3OWM0YWVkYzE3ZS4uYWExZWMzNWRjMTg3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMKQEAgLTc2MiwxMCArNzYy
LDkgQEAgc3RhdGljIGludCB0dG1fZG1hX3Bvb2xfYWxsb2NfbmV3X3BhZ2VzKHN0cnVjdCBkbWFf
cG9vbCAqcG9vbCwKIAkJcmV0dXJuIC1FTk9NRU07CiAJfQogCi0JaWYgKGNvdW50ID4gMSkgewor
CWlmIChjb3VudCA+IDEpCiAJCXByX2RlYnVnKCIlczogKCVzOiVkKSBHZXR0aW5nICVkIHBhZ2Vz
XG4iLAogCQkJIHBvb2wtPmRldl9uYW1lLCBwb29sLT5uYW1lLCBjdXJyZW50LT5waWQsIGNvdW50
KTsKLQl9CiAKIAlmb3IgKGkgPSAwLCBjcGFnZXMgPSAwOyBpIDwgY291bnQ7ICsraSkgewogCQlk
bWFfcCA9IF9fdHRtX2RtYV9hbGxvY19wYWdlKHBvb2wpOwotLSAKMi4xNC4zCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

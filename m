From: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH 11/12] drm/ttm: Fix coding style in
 ttm_dma_pool_alloc_new_pages()
Date: Mon, 29 Jan 2018 08:55:12 -0500
Message-ID: <20180129135513.22538-12-tom.stdenis@amd.com>
References: <20180129135513.22538-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180129135513.22538-1-tom.stdenis@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org
Cc: Tom St Denis <tom.stdenis@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QWRkIG1pc3Npbmcge30gYnJhY2VzLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20u
c3RkZW5pc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Nf
ZG1hLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1h
LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jCmluZGV4IDQ2OWU2
OGUwNmJlNi4uZmNkMTY4MDRjNzM4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9wYWdlX2FsbG9jX2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2NfZG1hLmMKQEAgLTc2MywxMCArNzYzLDkgQEAgc3RhdGljIGludCB0dG1fZG1hX3Bvb2xfYWxs
b2NfbmV3X3BhZ2VzKHN0cnVjdCBkbWFfcG9vbCAqcG9vbCwKIAkJcmV0dXJuIC1FTk9NRU07CiAJ
fQogCi0JaWYgKGNvdW50ID4gMSkgeworCWlmIChjb3VudCA+IDEpCiAJCXByX2RlYnVnKCIlczog
KCVzOiVkKSBHZXR0aW5nICVkIHBhZ2VzXG4iLAogCQkJIHBvb2wtPmRldl9uYW1lLCBwb29sLT5u
YW1lLCBjdXJyZW50LT5waWQsIGNvdW50KTsKLQl9CiAKIAlmb3IgKGkgPSAwLCBjcGFnZXMgPSAw
OyBpIDwgY291bnQ7ICsraSkgewogCQlkbWFfcCA9IF9fdHRtX2RtYV9hbGxvY19wYWdlKHBvb2wp
OwotLSAKMi4xNC4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK

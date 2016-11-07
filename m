From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 3/4] drm/ttm: fix ttm_bo_wait
Date: Mon,  7 Nov 2016 16:16:15 -0500
Message-ID: <1478553376-18575-3-git-send-email-alexander.deucher@amd.com>
References: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1478553376-18575-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKcmVzZXJ2
YXRpb25fb2JqZWN0X3dhaXRfdGltZW91dF9yY3UoKSBzaG91bGQgZW5hYmxlIHNpZ25hbGluZyBl
dmVuIHdpdGggYSB6ZXJvCnRpbWVvdXQsIGJ1dCB0dG1fYm9fd2FpdCgpIGNhbiBhbHNvIGJlIGNh
bGxlZCBmcm9tIGF0b21pYyBjb250ZXh0IGFuZCB0aGVuIGl0CmlzIG5vdCBhIGdvb2QgaWRlYSB0
byBkbyB0aGlzLgoKUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8IDkgKysrKysrKyst
CiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvLmMKaW5kZXggZjZmZjU3OS4uZDUwNjM2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC0x
NjExLDcgKzE2MTEsMTQgQEAgRVhQT1JUX1NZTUJPTCh0dG1fYm9fdW5tYXBfdmlydHVhbCk7CiBp
bnQgdHRtX2JvX3dhaXQoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAkJYm9vbCBpbnRl
cnJ1cHRpYmxlLCBib29sIG5vX3dhaXQpCiB7Ci0JbG9uZyB0aW1lb3V0ID0gbm9fd2FpdCA/IDAg
OiAxNSAqIEhaOworCWxvbmcgdGltZW91dCA9IDE1ICogSFo7CisKKwlpZiAobm9fd2FpdCkgewor
CQlpZiAocmVzZXJ2YXRpb25fb2JqZWN0X3Rlc3Rfc2lnbmFsZWRfcmN1KGJvLT5yZXN2LCB0cnVl
KSkKKwkJCXJldHVybiAwOworCQllbHNlCisJCQlyZXR1cm4gLUVCVVNZOworCX0KIAogCXRpbWVv
dXQgPSByZXNlcnZhdGlvbl9vYmplY3Rfd2FpdF90aW1lb3V0X3JjdShiby0+cmVzdiwgdHJ1ZSwK
IAkJCQkJCSAgICAgIGludGVycnVwdGlibGUsIHRpbWVvdXQpOwotLSAKMi41LjUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

From: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH 04/12] drm/ttm: Fix indentation in ttm_tt_swapout()
Date: Fri, 26 Jan 2018 13:29:03 -0500
Message-ID: <20180126182911.20761-5-tom.stdenis@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180126182911.20761-1-tom.stdenis@amd.com>
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

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3R0LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCmluZGV4IGU5MGQzZWQ2
MjgzZi4uOTVhNzdkYWI4Y2M5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90
dC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKQEAgLTM1Miw4ICszNTIsOSBA
QCBpbnQgdHRtX3R0X3N3YXBvdXQoc3RydWN0IHR0bV90dCAqdHRtLCBzdHJ1Y3QgZmlsZSAqcGVy
c2lzdGVudF9zd2FwX3N0b3JhZ2UpCiAJCQlwcl9lcnIoIkZhaWxlZCBhbGxvY2F0aW5nIHN3YXAg
c3RvcmFnZVxuIik7CiAJCQlyZXR1cm4gUFRSX0VSUihzd2FwX3N0b3JhZ2UpOwogCQl9Ci0JfSBl
bHNlCisJfSBlbHNlIHsKIAkJc3dhcF9zdG9yYWdlID0gcGVyc2lzdGVudF9zd2FwX3N0b3JhZ2U7
CisJfQogCiAJc3dhcF9zcGFjZSA9IHN3YXBfc3RvcmFnZS0+Zl9tYXBwaW5nOwogCi0tIAoyLjE0
LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

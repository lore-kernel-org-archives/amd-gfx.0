From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/12] drm/ttm: Fix coding style in ttm_tt_swapout()
Date: Mon, 29 Jan 2018 08:55:11 -0500
Message-ID: <20180129135513.22538-11-tom.stdenis@amd.com>
References: <20180129135513.22538-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180129135513.22538-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

QWRkIG1pc3Npbmcge30gYnJhY2VzLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20u
c3RkZW5pc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV90dC5jCmluZGV4IGU5MGQzZWQ2MjgzZi4uOTVhNzdkYWI4Y2M5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X3R0LmMKQEAgLTM1Miw4ICszNTIsOSBAQCBpbnQgdHRtX3R0X3N3YXBvdXQoc3RydWN0IHR0bV90
dCAqdHRtLCBzdHJ1Y3QgZmlsZSAqcGVyc2lzdGVudF9zd2FwX3N0b3JhZ2UpCiAJCQlwcl9lcnIo
IkZhaWxlZCBhbGxvY2F0aW5nIHN3YXAgc3RvcmFnZVxuIik7CiAJCQlyZXR1cm4gUFRSX0VSUihz
d2FwX3N0b3JhZ2UpOwogCQl9Ci0JfSBlbHNlCisJfSBlbHNlIHsKIAkJc3dhcF9zdG9yYWdlID0g
cGVyc2lzdGVudF9zd2FwX3N0b3JhZ2U7CisJfQogCiAJc3dhcF9zcGFjZSA9IHN3YXBfc3RvcmFn
ZS0+Zl9tYXBwaW5nOwogCi0tIAoyLjE0LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=

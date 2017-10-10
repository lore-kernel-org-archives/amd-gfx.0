From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 034/103] drm/amd/display: Only reset top pipe back end.
Date: Tue, 10 Oct 2017 18:40:03 -0400
Message-ID: <20171010224112.3023-35-harry.wentland@amd.com>
References: <20171010224112.3023-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171010224112.3023-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9u
eSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhh
cnJ5LldlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKaW5kZXggNGU0ZjIwYmE1NjQzLi4wMTQ5MTFl
YmRiZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9k
Y24xMF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKQEAgLTEyNzAsNiArMTI3MCw5IEBAIHN0YXRpYyB2
b2lkIHJlc2V0X2h3X2N0eF93cmFwKAogCQlpZiAoIXBpcGVfY3R4X29sZC0+c3RyZWFtKQogCQkJ
Y29udGludWU7CiAKKwkJaWYgKHBpcGVfY3R4X29sZC0+dG9wX3BpcGUpCisJCQljb250aW51ZTsK
KwogCQlpZiAoIXBpcGVfY3R4LT5zdHJlYW0gfHwKIAkJCQlwaXBlX25lZWRfcmVwcm9ncmFtKHBp
cGVfY3R4X29sZCwgcGlwZV9jdHgpKSB7CiAJCQlzdHJ1Y3QgY2xvY2tfc291cmNlICpvbGRfY2xr
ID0gcGlwZV9jdHhfb2xkLT5jbG9ja19zb3VyY2U7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

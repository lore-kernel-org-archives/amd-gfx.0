From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/14] drm/amd/display: fix single link DVI has no display
Date: Wed, 8 Aug 2018 10:53:00 -0400
Message-ID: <1533739990-27502-5-git-send-email-sunpeng.li@amd.com>
References: <1533739990-27502-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533739990-27502-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KCkNoYW5nZS1JZDogSWU3
M2MxOTBlYjdjYWY4ZDA3ZGY2NmIwZjk0Mjk3ZTJkYWNkMjRhZmUKU2lnbmVkLW9mZi1ieTogQ2hh
cmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERteXRybyBMYWt0
eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1
bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCmluZGV4IDcxYjk0
ZTMuLjhlYjRlZjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19saW5rLmMKQEAgLTE4MTIsNiArMTgxMiw4IEBAIHN0YXRpYyB2b2lkIGVuYWJsZV9saW5rX2hk
bWkoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKIAlib29sIGlzX3ZnYV9tb2RlID0gKHN0cmVh
bS0+dGltaW5nLmhfYWRkcmVzc2FibGUgPT0gNjQwKQogCQkJJiYgKHN0cmVhbS0+dGltaW5nLnZf
YWRkcmVzc2FibGUgPT0gNDgwKTsKIAorCWlmIChzdHJlYW0tPnBoeV9waXhfY2xrID09IDApCisJ
CXN0cmVhbS0+cGh5X3BpeF9jbGsgPSBzdHJlYW0tPnRpbWluZy5waXhfY2xrX2toejsKIAlpZiAo
c3RyZWFtLT5waHlfcGl4X2NsayA+IDM0MDAwMCkKIAkJaXNfb3Zlcl8zNDBtaHogPSB0cnVlOwog
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

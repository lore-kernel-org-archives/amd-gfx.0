From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 62/87] drm/amd/display: allocate 4 ddc engines for RV2
Date: Mon, 15 Jul 2019 17:20:24 -0400
Message-ID: <20190715212049.4584-63-sunpeng.li@amd.com>
References: <20190715212049.4584-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212049.4584-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Aric Cyr <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, Derek Lai <Derek.Lai-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRGVyZWsgTGFpIDxEZXJlay5MYWlAYW1kLmNvbT4KCltXaHldCkRyaXZlciB3aWxsIGNy
ZWF0ZSAwLCAxLCBhbmQgMiBkZGMgZW5naW5lcyBmb3IgUlYyLApidXQgc29tZSBwbGF0Zm9ybXMg
dXNlZCAwLCAxLCBhbmQgMy4KCltIb3ddClN0aWxsIGFsbG9jYXRlIDQgZGRjIGVuZ2luZXMgZm9y
IFJWMi4KClNpZ25lZC1vZmYtYnk6IERlcmVrIExhaSA8RGVyZWsuTGFpQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3Vu
cGVuZy5saUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF9yZXNvdXJjZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMTAvZGNuMTBfcmVzb3VyY2UuYwppbmRleCAyOWZkM2NiOTQyMmIuLjJhMDE2NDVjNGJm
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEw
X3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2Rj
bjEwX3Jlc291cmNlLmMKQEAgLTUwNiw3ICs1MDYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJl
c291cmNlX2NhcHMgcnYyX3Jlc19jYXAgPSB7CiAJCS5udW1fYXVkaW8gPSAzLAogCQkubnVtX3N0
cmVhbV9lbmNvZGVyID0gMywKIAkJLm51bV9wbGwgPSAzLAotCQkubnVtX2RkYyA9IDMsCisJCS5u
dW1fZGRjID0gNCwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGNfcGxhbmVfY2FwIHBsYW5l
X2NhcCA9IHsKLS0gCjIuMjIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4

From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 45/87] drm/amd/display: Remove second initialization of pp_smu
Date: Mon, 15 Jul 2019 17:20:07 -0400
Message-ID: <20190715212049.4584-46-sunpeng.li@amd.com>
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
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Jaehyun Chung <Jaehyun.Chung-5C7GfCeVMHo@public.gmane.org>, Alvin Lee <alvin.lee2-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWx2aW4gTGVlIDxhbHZpbi5sZWUyQGFtZC5jb20+Cgpbd2h5XQpXZSBpbml0aWFsaXpl
IHBwX3NtdSB0d2ljZQoKW2hvd10KUmVtb3ZlIHNlY29uZCBpbml0aWFsaXphdGlvbiBvZiBwcF9z
bXUKClNpZ25lZC1vZmYtYnk6IEFsdmluIExlZSA8YWx2aW4ubGVlMkBhbWQuY29tPgpSZXZpZXdl
ZC1ieTogSmFlaHl1biBDaHVuZyA8SmFlaHl1bi5DaHVuZ0BhbWQuY29tPgpBY2tlZC1ieTogTGVv
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Nsa19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Nsa19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jCmluZGV4IDQ4NDJjOTE3NzFk
OC4uZTlhN2E3YWYxMWRmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2xrX21nci9kY24yMC9kY24yMF9jbGtfbWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jCkBAIC0zNDYsOCArMzQ2
LDYgQEAgdm9pZCBkY24yMF9jbGtfbWdyX2NvbnN0cnVjdCgKIAogCWNsa19tZ3ItPmJhc2UuZHBy
ZWZjbGtfa2h6ID0gNzAwMDAwOyAvLyA3MDAgTUh6IHBsYW5uZWQgaWYgVkNPIGlzIDMuODUgR0h6
LCB3aWxsIGJlIHJldHJpZXZlZAogCi0JY2xrX21nci0+cHBfc211ID0gcHBfc211OwotCiAJaWYg
KElTX0ZQR0FfTUFYSU1VU19EQyhjdHgtPmRjZV9lbnZpcm9ubWVudCkpIHsKIAkJZGNuMl9mdW5j
cy51cGRhdGVfY2xvY2tzID0gZGNuMl91cGRhdGVfY2xvY2tzX2ZwZ2E7CiAJCWNsa19tZ3ItPmRl
bnRpc3RfdmNvX2ZyZXFfa2h6ID0gMzg1MDAwMDsKLS0gCjIuMjIuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

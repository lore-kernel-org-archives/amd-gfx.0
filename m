From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: add BACO platformCaps for VEGA20
Date: Fri, 11 Oct 2019 19:10:28 +0800
Message-ID: <1570792228-11189-4-git-send-email-le.ma@amd.com>
References: <1570792228-11189-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570792228-11189-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

QkFDTyByZXNldCBpcyBuZWVkZWQgZm9yIFJBUyByZWNvdmVyeS4KCkNoYW5nZS1JZDogSTgyMDdm
YzMxNDc0NDQ2OGM4OWJhNGEwMzBjYjJiYjE1YjA4MmFhYzcKU2lnbmVkLW9mZi1ieTogTGUgTWEg
PGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Iv
dmVnYTIwX2h3bWdyLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9o
d21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdy
LmMKaW5kZXggNjYyOWM0NzUuLjNkM2M2NDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5jCkBAIC0xODMsNiArMTgzLDkgQEAgc3Rh
dGljIGludCB2ZWdhMjBfc2V0X2ZlYXR1cmVzX3BsYXRmb3JtX2NhcHMoc3RydWN0IHBwX2h3bWdy
ICpod21ncikKIAkJCVBITV9QbGF0Zm9ybUNhcHNfVGFibGVsZXNzSGFyZHdhcmVJbnRlcmZhY2Up
OwogCiAJcGhtX2NhcF9zZXQoaHdtZ3ItPnBsYXRmb3JtX2Rlc2NyaXB0b3IucGxhdGZvcm1DYXBz
LAorCQkJUEhNX1BsYXRmb3JtQ2Fwc19CQUNPKTsKKworCXBobV9jYXBfc2V0KGh3bWdyLT5wbGF0
Zm9ybV9kZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywKIAkJCVBITV9QbGF0Zm9ybUNhcHNfRW5hYmxl
U01VN1RoZXJtYWxNYW5hZ2VtZW50KTsKIAogCWlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19T
VVBQT1JUX1VWRCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=

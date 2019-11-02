From: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for Navi14
Date: Sat, 2 Nov 2019 01:18:09 +0000
Message-ID: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>, "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>, "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
Cc: "Yeh, Eagle" <Eagle.Yeh-5C7GfCeVMHo@public.gmane.org>, "Lazare, Jordan" <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+CkRhdGU6IEZyaSwgMSBOb3YgMjAxOSAy
MToxMDoxNyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lO
RV9JRF9ESUdEIGNvbmRpdGlvbiBjaGVjayBmb3IgTmF2aTE0CgpbV2h5XQpOYXZpMTAgaGFzIDYg
UEhZLCBidXQgTmF2aTE0IG9ubHkgaGFzIDUgUEhZLCB0aGF0IGlzCmJlY2F1c2UgdGhlcmUgaXMg
bm8gRU5HSU5FX0lEX0RJR0QgaW4gTmF2aTE0LiBXaXRob3V0CnRoaXMgcGF0Y2gsIG1hbnkgSERN
SSByZWxhdGVkIGlzc3VlcyAoZS5nLiBIRE1JIFMzCnJlc3VtZSBmYWlsdXJlLCBIRE1JIHBpbmsg
c2NyZWVuIG9uIGJvb3QpIHdpbGwgYmUKb2JzZXJ2ZWQuCgpbSG93XQpJZiBlbmdfaWQgaXMgbGFy
Z2VyIHRoYW4gRU5HSU5FX0lEX0RJR0QsIHRoZW4KYWRkIGVuZ19pZCBieSAxLgoKU2lnbmVkLW9m
Zi1ieTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKaW5kZXggOTI0YzJlMzAzNTg4Li5jZjg4NjQ4
M2UzODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9k
Y24yMF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9yZXNvdXJjZS5jCkBAIC0xMTUyLDYgKzExNTIsOSBAQCBzdHJ1Y3Qgc3RyZWFtX2Vu
Y29kZXIgKmRjbjIwX3N0cmVhbV9lbmNvZGVyX2NyZWF0ZSgKICAgICAgICBpZiAoIWVuYzEpCiAg
ICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKCisgICAgICAgaWYgKGVuZ19pZCA+PSBFTkdJTkVf
SURfRElHRCkKKyAgICAgICAgICAgICAgIGVuZ19pZCsrOworCiAgICAgICAgZGNuMjBfc3RyZWFt
X2VuY29kZXJfY29uc3RydWN0KGVuYzEsIGN0eCwgY3R4LT5kY19iaW9zLCBlbmdfaWQsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3RyZWFtX2VuY19yZWdzW2VuZ19p
ZF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc2Vfc2hpZnQsICZz
ZV9tYXNrKTsKLS0KMi4yMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwoKYW1kLWdmeCBtYWlsaW5nIGxpc3QKCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

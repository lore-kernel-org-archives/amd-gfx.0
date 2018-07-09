From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: move cache window setup after power and clock
 resume
Date: Mon,  9 Jul 2018 12:11:38 -0400
Message-ID: <20180709161138.5319-3-leo.liu@amd.com>
References: <20180709161138.5319-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180709161138.5319-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

VG8gbWFrZSByZWdpc3RlciByZWFkL3dyaXRlIHJlbGlhYmxlLiBBbG9uZyB3aXRoIHRoZSBwcmV2
aW91cyBwYXRjaCwKVkNOIHdpbGwgd29yayB3aXRoIGRwbSBkaXNhYmxlZCBjYXNlLgoKU2lnbmVk
LW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92MV8wLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMK
aW5kZXggYjgyYzkyMDg0YjZmLi5jYTQyNjViYzEwYjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YxXzAuYwpAQCAtNjAwLDEyICs2MDAsMTIgQEAgc3RhdGljIGludCB2Y25fdjFfMF9z
dGFydChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkvKiBkaXNhYmxlIGJ5dGUgc3dhcHBp
bmcgKi8KIAlsbWlfc3dhcF9jbnRsID0gMDsKIAotCXZjbl92MV8wX21jX3Jlc3VtZShhZGV2KTsK
LQogCXZjbl8xXzBfZGlzYWJsZV9zdGF0aWNfcG93ZXJfZ2F0aW5nKGFkZXYpOwogCS8qIGRpc2Fi
bGUgY2xvY2sgZ2F0aW5nICovCiAJdmNuX3YxXzBfZGlzYWJsZV9jbG9ja19nYXRpbmcoYWRldik7
CiAKKwl2Y25fdjFfMF9tY19yZXN1bWUoYWRldik7CisKIAkvKiBkaXNhYmxlIGludGVydXB0ICov
CiAJV1JFRzMyX1AoU09DMTVfUkVHX09GRlNFVChVVkQsIDAsIG1tVVZEX01BU1RJTlRfRU4pLCAw
LAogCQkJflVWRF9NQVNUSU5UX0VOX19WQ1BVX0VOX01BU0spOwotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

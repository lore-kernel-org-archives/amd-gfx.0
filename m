From: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: skip ring soft reset on SR-IOV VF
Date: Wed, 14 Nov 2018 16:23:24 +0800
Message-ID: <1542183804-3021-1-git-send-email-Trigger.Huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>

V2hlbiBURFIgaGFwcGVuZWQgb24gU1ItSU9WIFZGLCB0aGUgaG9zdCBIeXBlcnZpc29yIG1heSBo
YXMgYWxyZWFkeQpkb25lIHRoZSBWRiBGTFIsIHRoZW4sIHRoZSByZS1pbml0aWFsaXphdGlvbiBm
bG93IGluIEtNRCBpcyBhIG11c3QuClRoZSBzYW1lIGxvZ2ljIGlzIGluIGFtZGdwdV9kZXZpY2Vf
aXBfY2hlY2tfc29mdF9yZXNldCwgdG9vCgpTaWduZWQtb2ZmLWJ5OiBUcmlnZ2VyIEh1YW5nIDxU
cmlnZ2VyLkh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3JpbmcuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKaW5kZXggNWI3NWJkYy4uMTRiZDY3
YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCkBAIC0zOTcsNiAr
Mzk3LDkgQEAgYm9vbCBhbWRncHVfcmluZ19zb2Z0X3JlY292ZXJ5KHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywgdW5zaWduZWQgaW50IHZtaWQsCiB7CiAJa3RpbWVfdCBkZWFkbGluZSA9IGt0aW1l
X2FkZF91cyhrdGltZV9nZXQoKSwgMTAwMDApOwogCisJaWYgKGFtZGdwdV9zcmlvdl92ZihyaW5n
LT5hZGV2KSkKKwkJcmV0dXJuIGZhbHNlOworCiAJaWYgKCFyaW5nLT5mdW5jcy0+c29mdF9yZWNv
dmVyeSkKIAkJcmV0dXJuIGZhbHNlOwogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

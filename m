From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] drm/amdgpu: fix GFX10 missing CSIB set
Date: Tue, 26 Nov 2019 19:50:20 +0800
Message-ID: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

c3RpbGwgbmVlZCB0byBpbml0IGNzYiBldmVuIGZvciBTUklPVgoKU2lnbmVkLW9mZi1ieTogTW9u
ayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5k
ZXggNGQ2ZGYzNS4uODc5YzBhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMKQEAgLTE5MjYsMTQgKzE5MjYsMTYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3Vt
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgcjsKIAotCWlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpCi0JCXJldHVybiAwOwotCiAJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRf
dHlwZSA9PSBBTURHUFVfRldfTE9BRF9QU1ApIHsKIAkJciA9IGdmeF92MTBfMF93YWl0X2Zvcl9y
bGNfYXV0b2xvYWRfY29tcGxldGUoYWRldik7CiAJCWlmIChyKQogCQkJcmV0dXJuIHI7CiAKKwkJ
aWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQkJZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYp
OworCQkJcmV0dXJuIDA7CisJCX0KKwogCQlyID0gZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7CiAJ
CWlmIChyKQogCQkJcmV0dXJuIHI7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4

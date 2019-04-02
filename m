From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Adjust IB test timeout for XGMI configuration
Date: Tue, 2 Apr 2019 18:12:00 +0000
Message-ID: <1554228693-28822-1-git-send-email-shaoyun.liu@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

T24gWEdNSSBjb25maWd1cmF0aW9uIHRoZSBpYiB0ZXN0IG1heSB0b29rcyBsb25nZXIgdG8gZmlu
aXNoCgpDaGFuZ2UtSWQ6IElmM2FmZDhlYWMzYzM0MmQzMmMzODc4MDRiNTFmYzRhNGJkZDM1ZDM1
ClNpZ25lZC1vZmYtYnk6IHNoYW95dW5sIDxzaGFveXVuLmxpdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCmlu
ZGV4IDBiOGVmMmQuLjQ1ZjI1MWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jCkBAIC0zNDYsNiArMzQ2LDkgQEAgaW50IGFtZGdwdV9pYl9yaW5nX3Rlc3RzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCQl0bW9fZ2Z4ID0gOCAqIEFNREdQVV9JQl9URVNUX1RJTUVP
VVQ7CiAJfQogCisJaWYgKGFkZXYtPmdtYy54Z21pLmhpdmVfaWQpCisJCXRtb19nZnggPSAyICog
QU1ER1BVX0lCX1RFU1RfVElNRU9VVDsKKwogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fcmlu
Z3M7ICsraSkgewogCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsK
IAkJbG9uZyB0bW87Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4

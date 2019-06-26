From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: remove unnecessary warning message on gpu reset
Date: Wed, 26 Jun 2019 17:50:02 +0000
Message-ID: <1561571394-16348-1-git-send-email-shaoyun.liu@amd.com>
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

SW4gWEdNSSBjb25maWd1cmF0aW9uLCBtb3JlIHRoYW4gb25lIGFzaWMgY2FuIGJlIHJlc2V0IGF0
IHNhbWUgdGltZSwNCmtmZCBpcyBhYmxlIHRvIGhhbmRsZSB0aGlzIGFuZCBubyBuZWVkIHRvIHRy
aWdnZXIgdGhlIHdhcm5pbmcNCg0KQ2hhbmdlLUlkOiBJZjMzOTUwMzg2MGU4NmVlMWRiZWVkMjk0
YmExYzEwM2ZjY2U3MGI3Yg0KU2lnbmVkLW9mZi1ieTogc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFt
ZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgfCAx
IC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jDQppbmRleCAyNmVhNDZkLi4yZTJmNzI0IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCkBAIC03MzgsNyArNzM4LDYgQEAgaW50IGtn
ZDJrZmRfcG9zdF9yZXNldChzdHJ1Y3Qga2ZkX2RldiAqa2ZkKQ0KIAlpZiAocmV0KQ0KIAkJcmV0
dXJuIHJldDsNCiAJY291bnQgPSBhdG9taWNfZGVjX3JldHVybigma2ZkX2xvY2tlZCk7DQotCVdB
Uk5fT05DRShjb3VudCAhPSAwLCAiS0ZEIHJlc2V0IHJlZi4gZXJyb3IiKTsNCiANCiAJYXRvbWlj
X3NldCgma2ZkLT5zcmFtX2VjY19mbGFnLCAwKTsNCiANCi0tIA0KMi43LjQNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

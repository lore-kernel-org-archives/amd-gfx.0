From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/10] drm/amdkfd: init kernel queue for renoir
Date: Wed, 4 Sep 2019 15:48:29 +0000
Message-ID: <20190904154803.5102-7-ray.huang@amd.com>
References: <20190904154803.5102-1-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190904154803.5102-1-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

UmVub2lyIGlzIEdGWCB2OSwgc28gaW5pdCB2OSBrZXJuZWwgcXVldWUuCgpTaWduZWQtb2ZmLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5l
bF9xdWV1ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5j
CmluZGV4IDI2YzY2YmIuLjI0NjJkMjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfa2VybmVsX3F1ZXVlLmMKQEAgLTM2NCw2ICszNjQsNyBAQCBzdHJ1Y3Qga2VybmVsX3F1
ZXVlICprZXJuZWxfcXVldWVfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqZGV2LAogCWNhc2UgQ0hJUF9W
RUdBMTI6CiAJY2FzZSBDSElQX1ZFR0EyMDoKIAljYXNlIENISVBfUkFWRU46CisJY2FzZSBDSElQ
X1JFTk9JUjoKIAkJa2VybmVsX3F1ZXVlX2luaXRfdjkoJmtxLT5vcHNfYXNpY19zcGVjaWZpYyk7
CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9OQVZJMTA6Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

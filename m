From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: remove unnecessary warning message on gpu
 reset
Date: Wed, 26 Jun 2019 17:50:48 +0000
Message-ID: <a9fa9777-c502-22f8-9cb7-97a082330eee@amd.com>
References: <1561571394-16348-1-git-send-email-shaoyun.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561571394-16348-1-git-send-email-shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <79A14804C34F2B4AAAACF3E6B73FD876-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Pg0KDQpBbmRyZXkNCg0KT24gNi8yNi8xOSAxOjUwIFBNLCBMaXUsIFNoYW95dW4gd3JvdGU6DQo+
IEluIFhHTUkgY29uZmlndXJhdGlvbiwgbW9yZSB0aGFuIG9uZSBhc2ljIGNhbiBiZSByZXNldCBh
dCBzYW1lIHRpbWUsDQo+IGtmZCBpcyBhYmxlIHRvIGhhbmRsZSB0aGlzIGFuZCBubyBuZWVkIHRv
IHRyaWdnZXIgdGhlIHdhcm5pbmcNCj4NCj4gQ2hhbmdlLUlkOiBJZjMzOTUwMzg2MGU4NmVlMWRi
ZWVkMjk0YmExYzEwM2ZjY2U3MGI3Yg0KPiBTaWduZWQtb2ZmLWJ5OiBzaGFveXVubCA8c2hhb3l1
bi5saXVAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZS5jIHwgMSAtDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPiBpbmRleCAyNmVhNDZkLi4y
ZTJmNzI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+
IEBAIC03MzgsNyArNzM4LDYgQEAgaW50IGtnZDJrZmRfcG9zdF9yZXNldChzdHJ1Y3Qga2ZkX2Rl
diAqa2ZkKQ0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICAJY291bnQgPSBh
dG9taWNfZGVjX3JldHVybigma2ZkX2xvY2tlZCk7DQo+IC0JV0FSTl9PTkNFKGNvdW50ICE9IDAs
ICJLRkQgcmVzZXQgcmVmLiBlcnJvciIpOw0KPiAgIA0KPiAgIAlhdG9taWNfc2V0KCZrZmQtPnNy
YW1fZWNjX2ZsYWcsIDApOw0KPiAgIA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4

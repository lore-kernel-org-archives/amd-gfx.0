From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: Disable idle optimization for chained runlist
Date: Thu, 20 Jun 2019 19:22:10 +0000
Message-ID: <20190620192155.20226-2-Felix.Kuehling@amd.com>
References: <20190620192155.20226-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190620192155.20226-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VGhpcyB3b3JrcyBhcm91bmQgZGlmZmljdWx0LXRvLXJlcHJvZHVjZSBzb2Z0IGhhbmdzIG9uIG92
ZXJzdWJzY3JpYmVkDQpydW5saXN0cy4NCg0KU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJu
ZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWVfdjkuYw0KaW5kZXggMDdmMDJmOGU0ZmU0Li4yZDVkZGYxOTliZDAgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYw0KQEAgLTEzNCw2
ICsxMzQsNyBAQCBzdGF0aWMgaW50IHBtX3J1bmxpc3Rfdjkoc3RydWN0IHBhY2tldF9tYW5hZ2Vy
ICpwbSwgdWludDMyX3QgKmJ1ZmZlciwNCiAJcGFja2V0LT5iaXRmaWVsZHM0LmliX3NpemUgPSBp
Yl9zaXplX2luX2R3b3JkczsNCiAJcGFja2V0LT5iaXRmaWVsZHM0LmNoYWluID0gY2hhaW4gPyAx
IDogMDsNCiAJcGFja2V0LT5iaXRmaWVsZHM0Lm9mZmxvYWRfcG9sbGluZyA9IDA7DQorCXBhY2tl
dC0+Yml0ZmllbGRzNC5jaGFpbmVkX3J1bmxpc3RfaWRsZV9kaXNhYmxlID0gY2hhaW4gPyAxIDog
MDsNCiAJcGFja2V0LT5iaXRmaWVsZHM0LnZhbGlkID0gMTsNCiAJcGFja2V0LT5iaXRmaWVsZHM0
LnByb2Nlc3NfY250ID0gY29uY3VycmVudF9wcm9jX2NudDsNCiAJcGFja2V0LT5vcmRpbmFsMiA9
IGxvd2VyXzMyX2JpdHMoaWIpOw0KLS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4

From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: disable gfxoff for navi12
Date: Thu, 15 Aug 2019 06:19:32 +0000
Message-ID: <DM5PR12MB1418CCC5DC229F147C80698EFCAC0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20190815034123.963-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190815034123.963-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZdWFuLCBY
aWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0OOaciDE15pelIDEx
OjQyDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+
OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47IFl1YW4sIFhpYW9qaWUgPFhp
YW9qaWUuWXVhbkBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTog
ZGlzYWJsZSBnZnhvZmYgZm9yIG5hdmkxMg0KDQpnZnhvZmYgZG9lc24ndCB3b3JrIG9uIG5hdmkx
MiB5ZXQsIHNvIGRpc2FibGUgaXQgZm9yIG5vdw0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1
YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4IDA2NmJhNTkzYWYyMy4u
ZDY0NDY2OWU1ZDkzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQpA
QCAtNTgwLDYgKzU4MCw3IEBAIHN0YXRpYyB2b2lkIGdmeF92MTBfMF9jaGVja19nZnhvZmZfZmxh
ZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5
cGUpIHsNCiAJY2FzZSBDSElQX05BVkkxMDoNCisJY2FzZSBDSElQX05BVkkxMjoNCiAJCWFkZXYt
PnBtLnBwX2ZlYXR1cmUgJj0gflBQX0dGWE9GRl9NQVNLOw0KIAkJYnJlYWs7DQogCWRlZmF1bHQ6
DQotLQ0KMi4yMC4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

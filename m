From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amdkfd: Only load sdma mqd when queue is active
Date: Tue, 4 Jun 2019 02:52:45 +0000
Message-ID: <1559616755-13116-2-git-send-email-Oak.Zeng@amd.com>
References: <1559616755-13116-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1559616755-13116-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

QWxzbyBjYWxscyBsb2FkX21xZCB3aXRoIGN1cnJlbnQtPm1tIHN0cnVjdC4gVGhlIG1tDQpzdHJ1
Y3QgaXMgdXNlZCB0byByZWFkIGJhY2sgdXNlciB3cHRyIG9mIHRoZSBxdWV1ZS4NCg0KQ2hhbmdl
LUlkOiBJMGY2ZDA4NTg3ODM1OGRjZDNhNDEzMDU0ZGJlNjFkMWNhMGZkZjY2ZA0KU2lnbmVkLW9m
Zi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyB8IDUgKysrKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQppbmRl
eCBlNWNiZjIxLi5kYzFhNzBiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQpAQCAtOTkwLDggKzk5MCwxMSBAQCBz
dGF0aWMgaW50IGNyZWF0ZV9zZG1hX3F1ZXVlX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9t
YW5hZ2VyICpkcW0sDQogCWlmIChyZXR2YWwpDQogCQlnb3RvIG91dF9kZWFsbG9jYXRlX2Rvb3Ji
ZWxsOw0KIA0KKwlpZiAoIXEtPnByb3BlcnRpZXMuaXNfYWN0aXZlKQ0KKwkJcmV0dXJuIDA7DQor
DQogCXJldHZhbCA9IG1xZF9tZ3ItPmxvYWRfbXFkKG1xZF9tZ3IsIHEtPm1xZCwgMCwgMCwgJnEt
PnByb3BlcnRpZXMsDQotCQkJCU5VTEwpOw0KKwkJCQljdXJyZW50LT5tbSk7DQogCWlmIChyZXR2
YWwpDQogCQlnb3RvIG91dF91bmluaXRfbXFkOw0KIA0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

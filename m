From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdkfd: Only initialize sdma vm for sdma queues
Date: Wed, 5 Jun 2019 16:06:41 +0000
Message-ID: <1559750793-16608-1-git-send-email-Oak.Zeng@amd.com>
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
Cc: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Freehill, Chris" <Chris.Freehill-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Liu, Alex" <Alex.Liu-5C7GfCeVMHo@public.gmane.org>

RG9uJ3QgZG8gdGhlIHNhbWUgZm9yIGNvbXB1dGUgcXVldWVzDQoNCkNoYW5nZS1JZDogSWQ1Zjc0
M2NhMTBjMmI3NjE1OTBiZmUxOGNhYjJmODAyZDNjMDRkMmQNClNpZ25lZC1vZmYtYnk6IE9hayBa
ZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgfCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCmluZGV4IGMxODM1NWQu
LjAwY2EzZGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlX3F1ZXVlX21hbmFnZXIuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCkBAIC0xMjA5LDggKzEyMDksOSBAQCBzdGF0aWMgaW50
IGNyZWF0ZV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwgc3Ry
dWN0IHF1ZXVlICpxLA0KIAkgKiB1cGRhdGVzIHRoZSBpc19ldmljdGVkIGZsYWcgYnV0IGlzIGEg
bm8tb3Agb3RoZXJ3aXNlLg0KIAkgKi8NCiAJcS0+cHJvcGVydGllcy5pc19ldmljdGVkID0gISFx
cGQtPmV2aWN0ZWQ7DQotDQotCWRxbS0+YXNpY19vcHMuaW5pdF9zZG1hX3ZtKGRxbSwgcSwgcXBk
KTsNCisJaWYgKHEtPnByb3BlcnRpZXMudHlwZSA9PSBLRkRfUVVFVUVfVFlQRV9TRE1BIHx8DQor
CQlxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfU0RNQV9YR01JKQ0KKwkJZHFt
LT5hc2ljX29wcy5pbml0X3NkbWFfdm0oZHFtLCBxLCBxcGQpOw0KIAlxLT5wcm9wZXJ0aWVzLnRi
YV9hZGRyID0gcXBkLT50YmFfYWRkcjsNCiAJcS0+cHJvcGVydGllcy50bWFfYWRkciA9IHFwZC0+
dG1hX2FkZHI7DQogCXJldHZhbCA9IG1xZF9tZ3ItPmluaXRfbXFkKG1xZF9tZ3IsICZxLT5tcWQs
ICZxLT5tcWRfbWVtX29iaiwNCi0tIA0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4

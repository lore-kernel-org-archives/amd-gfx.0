From: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/psp11: fix typo in comment
Date: Fri, 18 Oct 2019 11:07:06 +0000
Message-ID: <CA97BC1A-E475-4E59-B7AC-9C28256267F6@amd.com>
References: <20191018105923.8277-2-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191018105923.8277-2-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
Content-Language: zh-CN
Content-ID: <E24876707E38A241BC74A208E2E3A34F-t0aD9ArCiwdO0n7uQEQMm4CZgX+1HZI1@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Cc: "Long, Gang" <Gang.Long-5C7GfCeVMHo@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

U2VyaWVzIGlzIHJldmlld2VkIGJ5IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCg0K
PiDlnKggMjAxOeW5tDEw5pyIMTjml6XvvIwxODo1Oe+8jFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUu
WXVhbkBhbWQuY29tPiDlhpnpgZPvvJoNCj4gDQo+IO+7v1NpZ25lZC1vZmYtYnk6IFhpYW9qaWUg
WXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9wc3BfdjExXzAuYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvcHNwX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEx
XzAuYw0KPiBpbmRleCBkZmU4NWExZDc5YTUuLjRlYjViYWNiNTVmNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMNCj4gQEAgLTIzMiw3ICsyMzIsNyBAQCBzdGF0
aWMgaW50IHBzcF92MTFfMF9ib290bG9hZGVyX2xvYWRfa2RiKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQ0KPiAgICAvKiBDb3B5IFBTUCBLREIgYmluYXJ5IHRvIG1lbW9yeSAqLw0KPiAgICBtZW1j
cHkocHNwLT5md19wcmlfYnVmLCBwc3AtPmtkYl9zdGFydF9hZGRyLCBwc3AtPmtkYl9iaW5fc2l6
ZSk7DQo+IA0KPiAtICAgIC8qIFByb3ZpZGUgdGhlIHN5cyBkcml2ZXIgdG8gYm9vdGxvYWRlciAq
Lw0KPiArICAgIC8qIFByb3ZpZGUgdGhlIFBTUCBLREIgdG8gYm9vdGxvYWRlciAqLw0KPiAgICBX
UkVHMzJfU09DMTUoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM2LA0KPiAgICAgICAgICAgKHVp
bnQzMl90KShwc3AtPmZ3X3ByaV9tY19hZGRyID4+IDIwKSk7DQo+ICAgIHBzcF9nZnhkcnZfY29t
bWFuZF9yZWcgPSBQU1BfQkxfX0xPQURfS0VZX0RBVEFCQVNFOw0KPiAtLSANCj4gMi4yMC4xDQo+
IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

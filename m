From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/display: fix compiler errors
 [-Werror,-Wparentheses-equality]
Date: Tue, 5 Feb 2019 14:43:15 +0000
Message-ID: <989afa37-d307-8931-d228-e7666a2a5213@amd.com>
References: <20190204081546.24935-1-Pratik.Vishwakarma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190204081546.24935-1-Pratik.Vishwakarma-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <3A49CADC10DE0546AF8D4010EDD791C2-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMi0wNCAzOjE2IGEubS4sIFZpc2h3YWthcm1hLCBQcmF0aWsgd3JvdGU6DQo+IFJl
bW92ZSBleHRyYW5lb3VzIHBhcmVudGhlc2VzIGFyb3VuZCB0aGUgY29tcGFyaXNvbg0KPiB0byBz
aWxlbmNlIHRoaXMgd2FybmluZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdGlrIFZpc2h3YWth
cm1hIDxQcmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjX2F1dG8uYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2Fs
Y19hdXRvLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNf
YXV0by5jDQo+IGluZGV4IDdkMTAyYWMwZDYxYi4uMWVmMDA3NDMwMmM1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNfYXV0by5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY19hdXRv
LmMNCj4gQEAgLTYzLDcgKzYzLDcgQEAgdm9pZCBzY2FsZXJfc2V0dGluZ3NfY2FsY3VsYXRpb24o
c3RydWN0IGRjbl9id19pbnRlcm5hbF92YXJzICp2KQ0KPiAgCQlpZiAodi0+aW50ZXJsYWNlX291
dHB1dFtrXSA9PSAxLjApIHsNCj4gIAkJCXYtPnZfcmF0aW9ba10gPSAyLjAgKiB2LT52X3JhdGlv
W2tdOw0KPiAgCQl9DQo+IC0JCWlmICgodi0+dW5kZXJzY2FuX291dHB1dFtrXSA9PSAxLjApKSB7
DQo+ICsJCWlmICh2LT51bmRlcnNjYW5fb3V0cHV0W2tdID09IDEuMCkgew0KPiAgCQkJdi0+aF9y
YXRpb1trXSA9IHYtPmhfcmF0aW9ba10gKiB2LT51bmRlcl9zY2FuX2ZhY3RvcjsNCj4gIAkJCXYt
PnZfcmF0aW9ba10gPSB2LT52X3JhdGlvW2tdICogdi0+dW5kZXJfc2Nhbl9mYWN0b3I7DQo+ICAJ
CX0NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

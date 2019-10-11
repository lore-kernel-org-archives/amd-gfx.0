From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amd/display/dc/dce: remove some not used variables
Date: Fri, 11 Oct 2019 16:26:23 +0000
Message-ID: <6910512b-0af9-5c5e-834c-f55e8130307d@amd.com>
References: <1570602312-49690-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570602312-49690-1-git-send-email-zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <3CDB3402C7F5824C89D56655DA06B83B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4NCg0KSSB0aGluayBmb3IgYWxsIG9mIHRoZW0gd2Ugc2hv
dWxkIGp1c3QgZHJvcCB0aGUgUkVHX1JFQUQgY2FsbHMNCmNvbXBsZXRlbHkuIFRoZXkgbG9vayBs
aWtlIGxlZnRvdmVycyBmcm9tIHdoZW4gd2UgaGFkIGEgZGlmZmVyZW50DQpyZWdpc3RlciB1cGRh
dGUgc2NoZW1lIHRoYXQgd291bGQgcmVhZCB0aGUgcmVnaXN0ZXIsIHRoZW4gdXBkYXRlIG9yIGdl
dA0KdGhlIGZpZWxkIHZhbHVlLiBOb3cgd2UganVzdCB1c2UgdGhlIFJFR18gbWFjcm9zIHRoYXQg
d2lsbCBjb21iaW5lIHRoZQ0KcmVhZCB3aXRoIHRoZSBHRVQgb3IgVVBEQVRFIG9wZXJhdGlvbnMu
DQoNCkhhcnJ5DQoNCk9uIDIwMTktMTAtMDkgMjoyNSBhLm0uLCB6aGVuZ2JpbiB3cm90ZToNCj4g
emhlbmdiaW4gKDMpOg0KPiAgIGRybS9hbWQvZGlzcGxheTogUmVtb3ZlIHNldCBidXQgbm90IHVz
ZWQgdmFyaWFibGVzDQo+ICAgICAnYmxfcHdtX2NudGwnLCdwd21fcGVyaW9kX2NudGwnDQo+ICAg
ZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAndmFsdWUw
Jw0KPiAgIGRybS9hbWQvZGlzcGxheTogUmVtb3ZlIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGVz
ICdyZWd2YWwnLCdzcGVha2VycycNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9hYm0uYyAgICAgICAgICAgIHwgOCArKysrLS0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMgICB8IDMgKy0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5jIHwg
NSArLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9u
cygtKQ0KPiANCj4gLS0NCj4gMi43LjQNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=

From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/display: bypass stereo programming
Date: Wed, 4 Sep 2019 13:23:02 +0000
Message-ID: <e97ec062-028e-dff8-8d27-b874ca6f51f5@amd.com>
References: <1567577166-18064-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567577166-18064-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <6E1370A9AE9EF948AD348FFC54E22314-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOS0wNCAyOjA2IGEubS4sIExpdSwgQWFyb24gd3JvdGU6DQo+IEZyb206IFJvbWFu
IExpIDxSb21hbi5MaUBhbWQuY29tPg0KPiANCj4gaGFjayB0byBhdm9pZCBjcmFzaCBvbiByZW5v
aXINCj4gc2hvdWxkIGJlIHJlc29sdmVkIGFmdGVyIHVwY29taW5nIGdwaW8gcmVmYWN0b3Jpbmcg
cHJvbW90aW9uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBMaSA8Um9tYW4uTGlAYW1kLmNv
bT4NCg0KTmFjay4gVGhpcyBpcyBub3QgdGhlIHJpZ2h0IHdheSB0byBkbyB0aGlzIHVwc3RyZWFt
LiBXZSBzaG91bGRuJ3QgdXNlDQpjb21waWxlIHRpbWUgZ3VhcmQgdG8gY2hhbmdlIEFTSUMgYmVo
YXZpb3IuIFRoaXMgaXMgYSBicmluZ3VwLWJyYW5jaA0KY2hhbmdlIGFuZCBuZWVkcyB0byBiZSBy
ZXZpc2l0ZWQgZm9yIGFtZC1zdGcuDQoNCkhhcnJ5DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMgfCA2ICsrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIu
Yw0KPiBpbmRleCA1YjlkZDE2Li5lZTIxODZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jDQo+
IEBAIC0yODQ0LDYgKzI4NDQsMTIgQEAgc3RhdGljIHZvaWQgZGNuMTBfc2V0dXBfc3RlcmVvKHN0
cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgsIHN0cnVjdCBkYyAqZGMpDQo+ICB7DQo+ICAJc3RydWN0
IGNydGNfc3RlcmVvX2ZsYWdzIGZsYWdzID0geyAwIH07DQo+ICAJc3RydWN0IGRjX3N0cmVhbV9z
dGF0ZSAqc3RyZWFtID0gcGlwZV9jdHgtPnN0cmVhbTsNCj4gKyNpZmRlZiBDT05GSUdfRFJNX0FN
RF9EQ19EQ04yXzENCj4gKy8qIFRPRE86IHJlbW92ZSBhZnRlciBncGlvIHJlZmFjdG9yIGdldHMg
cHJvbW90ZWQNCj4gKyogICAgICAgIG90aGVyd2lzZSBpdCBjYXVzaW5nIGNyYXNoIG9uIFJlbm9p
cg0KPiArKi8NCj4gKwlyZXR1cm47DQo+ICsjZW5kaWYNCj4gIA0KPiAgCWRjbjEwX2NvbmZpZ19z
dGVyZW9fcGFyYW1ldGVycyhzdHJlYW0sICZmbGFncyk7DQo+ICANCj4gDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=

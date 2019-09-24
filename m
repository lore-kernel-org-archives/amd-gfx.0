From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/display: include slab.h in dcn21_resource.c
Date: Tue, 24 Sep 2019 15:15:18 +0000
Message-ID: <4a0d452b-8795-20d4-972d-7063dcdc9a92@amd.com>
References: <20190923205804.12300-1-alexander.deucher@amd.com>
 <9ad314e5-1a6f-f17f-ac1c-ec33aed2912e@amd.com>
 <CADnq5_NK57bqucbjp9Dn73kKPnhAqEvVHO68vZOvatOZ4pwCyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NK57bqucbjp9Dn73kKPnhAqEvVHO68vZOvatOZ4pwCyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <B87B089B8090874480562BE75EC3F76B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wOS0yMyA1OjU0IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gT24gTW9uLCBT
ZXAgMjMsIDIwMTkgYXQgNToxNCBQTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5AYW1kLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gT24gMjAxOS0wOS0yMyA0OjU4IHAubS4sIEFsZXggRGV1Y2hlciB3cm90
ZToNCj4+PiBJdCdzIGFwcGFyZW50bHkgbmVlZGVkIGluIHNvbWUgY29uZmlndXJhdGlvbnMuDQo+
Pg0KPj4gQ3VyaW91cyB3aGljaCBjb25maWcgZmFpbHMgYW5kIHdoYXQgY29tcGlsZXIgZXJyb3Jz
IHdlIGdldC4uLiBTb3VuZHMNCj4+IGxpa2Ugb3VyIGluY2x1ZGVzIGFyZSBtZXNzZWQgdXAgc29t
ZXdoZXJlLg0KPiANCj4gTm90IHN1cmUgZXhhY3RseToNCj4gaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMTkvOS8yMC85OTgNCj4gDQoNCkp1c3Qgbm90aWNlZCB0aGUgb3RoZXIgZGNuWFlfcmVzb3Vy
Y2UuYyBmaWxlcyBoYXZlIHRoYXQgYXMgd2VsbC4NCg0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IEFsZXgNCj4gDQo+Pg0K
Pj4gSGFycnkNCj4+DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIHwgMiArKw0KPj4+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYw0KPj4+IGluZGV4IDNjYTUx
MzlmMTI3My4uZGUxODIxODVmZTFmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMNCj4+PiBAQCAtMjMs
NiArMjMsOCBAQA0KPj4+ICAgKg0KPj4+ICAgKi8NCj4+Pg0KPj4+ICsjaW5jbHVkZSA8bGludXgv
c2xhYi5oPg0KPj4+ICsNCj4+PiAgI2luY2x1ZGUgImRtX3NlcnZpY2VzLmgiDQo+Pj4gICNpbmNs
dWRlICJkYy5oIg0KPj4+DQo+Pj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==

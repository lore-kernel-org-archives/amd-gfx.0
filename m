From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/5] GFX9 KIQ
Date: Wed, 24 May 2017 13:10:01 +0000
Message-ID: <BN6PR12MB1652617D3506D75744B56A55F7FE0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1494527730-30128-1-git-send-email-alexander.deucher@amd.com>
 <40533e4c-7f8f-70a4-2e15-3540da60b2b0@amd.com>
 <b4b2b241-d072-a227-9be4-a51ccd85d063@amd.com>
 <CADnq5_O+kbGLTR6H+a+7RRUz2etK5gJQt1YVsXEr3RE+UpoqyQ@mail.gmail.com>
 <CADnq5_NSwLQW6A3pTVLR2CHBeyNDE4jWx5J3FVDwH-7h53F1mQ@mail.gmail.com>
 <ae9e8d7c-ac6f-3fae-0986-0f74e106be09@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ae9e8d7c-ac6f-3fae-0986-0f74e106be09-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIFRvbSBT
dCBEZW5pcw0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyNCwgMjAxNyA3OjUwIEFNDQo+IFRvOiBB
bGV4IERldWNoZXINCj4gQ2M6IGFtZC1nZnggbGlzdA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAv
NV0gR0ZYOSBLSVENCj4gDQo+IE9uIDIzLzA1LzE3IDA1OjMyIFBNLCBBbGV4IERldWNoZXIgd3Jv
dGU6DQo+ID4gT24gVHVlLCBNYXkgMjMsIDIwMTcgYXQgNTozMSBQTSwgQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+PiBPbiBGcmksIE1heSAxMiwgMjAx
NyBhdCA3OjExIEFNLCBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+DQo+IHdyb3Rl
Og0KPiA+Pj4gT24gMTEvMDUvMTcgMDc6MzMgUE0sIFRvbSBTdCBEZW5pcyB3cm90ZToNCj4gPj4+
Pg0KPiA+Pj4+IE9uIDExLzA1LzE3IDAyOjM1IFBNLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+ID4+
Pj4+DQo+ID4+Pj4+IFRoZXNlIGFyZSB0aGUgbGFzdGUgb2YgdGhlIGdmeDkgS0lRIHBhdGNoZXMg
dGhhdCBoYXZlbid0IGxhbmRlZCB5ZXQuDQo+IENhbg0KPiA+Pj4+PiBzb21lb25lIHdpdGggZ2Z4
OSBjYXBhYmxlIGh3IHRlc3QgdGhpcyAodmVnYTEwIG9yIHJhdmVuKT8gIFRoaXMgaXMNCj4gbmVl
ZGVkDQo+ID4+Pj4+IHRvIGVuYWJsZSBwb3dlcmdhdGluZyBvbiBnZng5Lg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBUaGFua3MsDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IElmIG5vYm9keSBnZXRzIHRvIGl0
IGJ5IG1vcm5pbmcgSSdsbCB0cnkgaXQgb3V0IGZpcnN0IHRoaW5nIG9uIG15IHZlZ2ExMA0KPiA+
Pj4+IHRob3VnaCBteSBWQklPUyBtaWdodCBuZWVkIHVwZGF0aW5nLi4uDQo+ID4+Pg0KPiA+Pj4N
Cj4gPj4+DQo+ID4+PiBUaGV5IGRvbid0IGFwcGx5IG9uIHRvcCBvZiBlaXRoZXIgNC45IG5vciA0
LjExLi4uDQo+ID4+DQo+ID4+IE9kZC4gIFRoZXkgYXBwbGllZCBmb3IgbWUgKGF0IGxlYXN0IHRv
IHRoZSA0LjExIHRyZWUgSSBoYWQgY2hlY2tlZCBvdXQNCj4gPj4gd2hlbiBJIGxlZnQgdG93biku
ICBBdHRhY2hlZCBhZ2FpbiBqdXN0IGluIGNhc2UuDQo+IA0KPiBUaGlzIHNlcmllcyBhcHBsaWVz
IGZpbmUgYW5kIHNlZW1zIHRvIHdvcmsgaW4gYmFzaWMgdGVzdHMgKGdub21lICsgR0wNCj4gYXBw
cyArIHV2ZC92Y2UgYXBwcykgb24gbXkgdmVnYTEwLg0KPiANCj4gSGF2ZW4ndCB0cmllZCBvbiBy
YXZlbiB5ZXQuDQoNCkFsbCB0aGUgcmluZyBhbmQgSUIgdGVzdHMgcGFzcz8NCg0KPiANCj4gVG9t
DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

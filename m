From: "Cyr, Aric" <Aric.Cyr@amd.com>
Subject: RE: RFC for a render API to support adaptive sync and VRR
Date: Tue, 10 Apr 2018 17:13:08 +0000
Message-ID: <MWHPR12MB1837201365AE76E07CD906D482BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net>
 <ae9992e5-43ab-9636-13e1-8a5c692480b5@amd.com>
 <MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
 <fc53ce53-f02c-891d-4aa5-e9a11cbe3007@amd.com>
 <MWHPR12MB1837488A047C03E955282A4182BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
 <063d6dff-2b97-ef01-12bb-8a24125a58ec@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <063d6dff-2b97-ef01-12bb-8a24125a58ec@daenzer.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, Manasi Navare <manasi.d.navare@intel.com>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciBbbWFp
bHRvOm1pY2hlbEBkYWVuemVyLm5ldF0NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTAsIDIwMTgg
MTM6MDYNCj4gT24gMjAxOC0wNC0xMCAwNjoyNiBQTSwgQ3lyLCBBcmljIHdyb3RlOg0KPiA+IEZy
b206IEtvZW5pZywgQ2hyaXN0aWFuIFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDEwLCAyMDE4IDExOjQz
DQo+ID4NCj4gPj4gRm9yIHZpZGVvIGdhbWVzIHdlIGhhdmUgYSBzaW1pbGFyIHNpdHVhdGlvbiB3
aGVyZSBhIGZyYW1lIGlzIHJlbmRlcmVkDQo+ID4+IGZvciBhIGNlcnRhaW4gd29ybGQgdGltZSBh
bmQgaW4gdGhlIGlkZWFsIGNhc2Ugd2Ugd291bGQgYWN0dWFsbHkNCj4gPj4gZGlzcGxheSB0aGUg
ZnJhbWUgYXQgdGhpcyB3b3JsZCB0aW1lLg0KPiA+DQo+ID4gVGhhdCBzZWVtcyBsaWtlIGl0IHdv
dWxkIGJlIGEgcG9vcmx5IHdyaXR0ZW4gZ2FtZSB0aGF0IGZsaXBzIGxpa2UNCj4gPiB0aGF0LCB1
bmxlc3MgdGhleSBhcmUgZXhwbGljaXRseSB0cnlpbmcgdG8gdGhyb3R0bGUgdGhlIGZyYW1lcmF0
ZSBmb3INCj4gPiBzb21lIHJlYXNvbi4gIFdoZW4gYSBnYW1lIHByZXNlbnRzIGEgY29tcGxldGVk
IGZyYW1lLCB0aGV54oCZZCBsaWtlDQo+ID4gdGhhdCB0byBoYXBwZW4gYXMgc29vbiBhcyBwb3Nz
aWJsZS4NCj4gDQo+IFdoYXQgeW91J3JlIGRlc2NyaWJpbmcgaXMgd2hhdCBtb3N0IGdhbWVzIGhh
dmUgYmVlbiBkb2luZyB0cmFkaXRpb25hbGx5Lg0KPiBDcm90ZWFtJ3MgcmVzZWFyY2ggc2hvd3Mg
dGhhdCB0aGlzIHJlc3VsdHMgaW4gbWljcm8tc3R1dHRlcmluZywgYmVjYXVzZQ0KPiBmcmFtZXMg
bWF5IGJlIHByZXNlbnRlZCB0b28gZWFybHkuIFRvIGF2b2lkIHRoYXQsIHRoZXkgd2FudCB0bw0K
PiBleHBsaWNpdGx5IHRpbWUgZWFjaCBwcmVzZW50YXRpb24gYXMgZGVzY3JpYmVkIGJ5IENocmlz
dGlhbi4NCg0KWWVzLCBJIGFncmVlIGNvbXBsZXRlbHkuICBIb3dldmVyIHRoYXQncyBvbmx5IHRy
dWx5IHJlbGV2YW50IGZvciBmaXhlZCByZWZyZXNoZWQgcmF0ZSBkaXNwbGF5cy4NClRoaXMgaXMg
dGhlIHByaW1hcnkgcmVhc29uIGZvciBoYXZpbmcgQWRhcHRpdmUgU3luYy4gIA0KVGhlcmUgaXMg
bm8gcGVyZmVjdCB3YXkgdG8gc29sdmUgdGhpcyB3aXRob3V0IEFkYXB0aXZlIFN5bmMsIGJ1dCB5
ZXMgdGhleSBjYW4gY29tZSB1cCB3aXRoIGJldHRlciBhbGdvcml0aG1zIHRvIGltcHJvdmUgZml4
ZWQgcmVmcmVzaCByYXRlIGRpc3BsYXlzLg0KDQo+IA0KPiBNYXliZSB3ZSBzaG91bGQgdHJ5IGdl
dHRpbmcgdGhlIENyb3RlYW0gZ3V5cyByZXNlYXJjaGluZyB0aGlzIGludm9sdmVkDQo+IGRpcmVj
dGx5IGhlcmUuDQoNCkknZCBiZSBpbnRlcmVzdGVkIGluIGFueSByZXNlYXJjaCB0aGV5IGNvdWxk
IHNoYXJlLCBmb3Igc3VyZS4gIA0KV2UgYWxzbyBoYXZlIHllYXJzIG9mIGV4cGVyaWVuY2UgYW5k
IHJlc2VhcmNoIGhlcmUsIGJ1dCBub3QgZGlzdGlsbGVkIGludG8gYW55IHJlYWRpbHkgYXZhaWxh
YmxlIGZvcm1hdC4NCg0KPiANCj4gDQo+IC0tDQo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20NCj4gTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

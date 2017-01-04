From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [V2 1/1] drm/amdgpu/gfx8: add support kernel interface queue(KIQ)
Date: Wed, 4 Jan 2017 13:26:54 +0000
Message-ID: <CY4PR12MB1701517F2E7D90C0258C6029EB610@CY4PR12MB1701.namprd12.prod.outlook.com>
References: <1482476904-21674-1-git-send-email-Xiangliang.Yu@amd.com>
 <CY4PR12MB1701D664FEB2EF8FCFD4EBDBEB680@CY4PR12MB1701.namprd12.prod.outlook.com>
 <58632418.5040408@amd.com>
 <CY4PR12MB1701E0582B28FDC9AF4A1CF7EB680@CY4PR12MB1701.namprd12.prod.outlook.com>
 <d3a848b9-1789-0788-a9b1-e80d814a8e01@vodafone.de>
 <CY4PR12MB17018945F695389E673D2FBFEB610@CY4PR12MB1701.namprd12.prod.outlook.com>
 <09f8ecf6-5a0a-c65b-caf6-63ecae763e9b@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <09f8ecf6-5a0a-c65b-caf6-63ecae763e9b-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

PiA+PiBBbSAyOC4xMi4yMDE2IHVtIDAzOjU5IHNjaHJpZWIgWXUsIFhpYW5nbGlhbmc6DQo+ID4+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBhbWQtZ2Z4IFttYWls
dG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24NCj4gPj4+PiBCZWhh
bGYgT2YgemhvdWNtMQ0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjgsIDIwMTYg
MTA6MzIgQU0NCj4gPj4+PiBUbzogWXUsIFhpYW5nbGlhbmcgPFhpYW5nbGlhbmcuWXVAYW1kLmNv
bT47IGFtZC0NCj4gPj4+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+Pj4gQ2M6IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1YyIDEvMV0g
ZHJtL2FtZGdwdS9nZng4OiBhZGQgc3VwcG9ydCBrZXJuZWwgaW50ZXJmYWNlDQo+ID4+Pj4gcXVl
dWUoS0lRKQ0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDIwMTblubQxMuaciDI4
5pelIDEwOjI3LCBZdSwgWGlhbmdsaWFuZyB3cm90ZToNCj4gPj4+Pj4gKw0KPiA+Pj4+Pj4gKwlh
bWRncHVfYm9fa3VubWFwKGtpcS0+ZW9wX29iaik7DQo+ID4+Pj4+PiArDQo+ID4+Pj4gSSBzZWUg
aXQgaXMgaW4gbWFueSBwbGFjZXMsIHdoaWNoIGlzIGRvbid0IG5lZWQgSSB0aGluaywNCj4gPj4+
PiBhbWRncHVfYm9fZnJlZV9rZXJuZWwgd2lsbCBoYW5kbGUgaXQgaWYgSSdtIGNvcnJlY3QuDQo+
ID4+PiBNZW1vcnkga21hcCBzaG91bGQgYmUgZnJlZSBBU0FQIGZyb20gbWVtb3J5IG1hbmFnZW1l
bnQgcG9pbnQuDQo+ID4+IE5vLCB0aGF0IGlzIGNvbXBsZXRlbHkgdW5uZWNlc3NhcnkgYXMgbG9u
ZyBhcyB5b3UgZG9uJ3QgcnVuIGEgMzJiaXQNCj4gPj4gc3lzdGVtIHdpdGggdGlnaHQgYWRkcmVz
cyBzcGFjZS4NCj4gPiBXZSBjYW4ndCBkZWNpZGUgd2hhdCBPUyB0byB1c2UuICBJIGFncmVlIHdp
dGggbW9uaydzIGNvbW1lbnQgdGhhdCBiZXR0ZXINCj4gdG8gdW5tYXAgaXQgaWYgY3B1IGRvbid0
IHVzZS4NCj4gDQo+IE5vIGl0IGlzbid0LiBBcyBJIHNhaWQgdGhpcyBpcyBvbmx5IG5lY2Vzc2Fy
eSBvbiAzMmJpdCBzeXN0ZW1zIHdpdGggdGlnaHQgYWRkcmVzcw0KPiBzcGFjZS4gSW4gb3RoZXIg
d29yZHMgd2Ugc2ltcGx5IGRvbid0IHJlYWxseSBzdXBwb3J0IHRoYXQgY29uZmlndXJhdGlvbiBh
bnkNCj4gbW9yZS4NCj4gDQo+IElmIHlvdSBkb24ndCBuZWVkIGl0IHRoZW4gd2h5IGRvIHlvdSB3
YW50IHRvIGttYXAgaXQgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPiANCg0KSW4gbXkgcGF0Y2gsIGZp
cnN0IGdldCBtcWQgYWRkcmVzcyB0byBmaWxsIG91dCBtcWQgY29udGV4dCB0aHJvdWdoIGttYXAs
IHRoZW4gc2V0dXAgY29tcHV0ZSBxdWV1ZSB3aXRoIGtpcSByaW5nLg0KDQpBbmQgSSBzZWUgdGhl
cmUgYXJlIGxvdCBvZiBzaW1pbGFyIHVzYWdlIGluIGFtZGdwdSwgZm9yIGV4YW1wbGUsIGdmeF92
OF8wX3JsY19pbml0IGZ1bmN0aW9uLiBDb3VsZCB5b3UgaGVscCB0byBleHBsYWluIGl0Pw0KDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

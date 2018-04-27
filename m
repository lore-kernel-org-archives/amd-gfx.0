From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: reject kms open if TDR not finished or
 failed
Date: Fri, 27 Apr 2018 08:15:43 +0000
Message-ID: <CY4PR12MB11253279D4404CF482FD7CF08F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
References: <1524638384-31977-1-git-send-email-Emily.Deng@amd.com>
 <5bede6f6-24b2-8a3a-d3d8-9a37ac6d13c8@daenzer.net>
 <CY4PR12MB11254FFDBB4FCCF91CBDE9758F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <e7756d73-aa65-b351-2b1a-81ceea1e013f@daenzer.net>
 <CY4PR12MB112547536CD27B7FE2C330F38F8E0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <9d56b1c3-1e51-f3f1-17d6-c1615dea0a05@daenzer.net>
 <CY4PR12MB1125653A73D8A22533FB3FBE8F8D0@CY4PR12MB1125.namprd12.prod.outlook.com>
 <77a5af30-0371-4816-fcf5-0bbcffa4395c@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <77a5af30-0371-4816-fcf5-0bbcffa4395c-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Tm8sIEkgbWVhbiBkdXJpbmcgR1BVIHJlc2V0LCB0aGUgYXBwIHdpbGwgZmFpbCwgaXQgaXMgcmVh
c29uYWJsZS4gVGhlIGZsYWcgaW5fZ3B1X3Jlc2V0IGluZGljYXRlcyB0aGUgR1BVIGlzIGluIHJl
c2V0IHN0YXRlLCBhZnRlciByZXNldCwgd2Ugd2lsbCBzZXQgdGhlIGZsYWcgYmFjay4NCg0KQmVz
dCBXaXNoZXMsDQpFbWlseSBEZW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogTWljaGVsIETDpG56ZXIgW21haWx0bzptaWNoZWxAZGFlbnplci5uZXRdDQo+IFNlbnQ6
IEZyaWRheSwgQXByaWwgMjcsIDIwMTggMzo1MiBQTQ0KPiBUbzogRGVuZywgRW1pbHkgPEVtaWx5
LkRlbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4NCj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHUvc3Jpb3Y6IHJlamVjdCBrbXMgb3BlbiBpZiBURFIgbm90IGZpbmlzaGVkDQo+IG9yIGZhaWxl
ZA0KPiANCj4gT24gMjAxOC0wNC0yNyAwNzoyOSBBTSwgRGVuZywgRW1pbHkgd3JvdGU6DQo+ID4g
U29ycnksIEkgZG9uJ3QgZ2V0IHlvdXIgcG9pbnQsIHdoZW4gdGhlIEdQVSBpcyBkb2luZyBhIHJl
c2V0LCBldmVuIGxldA0KPiA+IHRoZSBka21zIG9wZW4sIHRoZSB1c2Vyc3BhY2Ugd2lsbCBzdGls
bCBmYWlsLCBzbyBkdXJpbmcgdGhlIHJlc2V0LCBhbnkNCj4gPiBkcml2ZXIgb3BlbiBrbXMgaXMg
bWVhbmluZ2xlc3MuDQo+IA0KPiBUaGF0IG5lZWRzIHRvIGJlIGZpeGVkLCB0aGVuLiBJZiB0aGUg
R1BVIHJlc2V0IHN1Y2NlZWRzLCB1c2Vyc3BhY2Ugc2hvdWxkbid0DQo+IGhhdmUgdG8gZmFpbC4N
Cj4gDQo+IA0KPiAtLQ0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQo+IExpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

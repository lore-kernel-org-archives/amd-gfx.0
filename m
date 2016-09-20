From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Tue, 20 Sep 2016 04:05:44 +0000
Message-ID: <MWHPR12MB1694A4272F0252A1DE07D68CF7F70@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
 <3790458b-489a-f408-860d-f9650a9f5cab@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3790458b-489a-f408-860d-f9650a9f5cab-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?J01pY2hlbCBEw6RuemVyJw==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciBbbWFp
bHRvOm1pY2hlbEBkYWVuemVyLm5ldF0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTksIDIw
MTYgMTA6MzcgUE0NCj4gVG86IEh1YW5nLCBSYXk7IERldWNoZXIsIEFsZXhhbmRlcg0KPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFdhbmcsIEtlbjsgSHVhbiwgQWx2aW4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIGRybS9hbWRncHU6IGltcGxlbWVudCByYXN0ZXIgY29u
ZmlndXJhdGlvbg0KPiANCj4gT24gMTgvMDkvMTYgMTE6MzYgQU0sIEh1YW5nIFJ1aSB3cm90ZToN
Cj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNldCBpcyB0byBpbnRyb2R1Y2UgdGhl
IHJhc3RlciBjb25maWd1cmF0aW9uIGZvciBhbGwgZ2Z4DQo+ID4gZ2VuZXJhdGlvbnMuDQo+IA0K
PiBXaGF0J3MgdGhlIG1vdGl2YXRpb24gZm9yIGRvaW5nIHRoaXMgaW4gdGhlIGtlcm5lbD8gTWVz
YSB3aWxsIHdyaXRlIGl0cw0KPiBvd24gdmFsdWVzIHRvIHRoZXNlIHJlZ2lzdGVycyBhbnl3YXku
DQoNCkl0J3MgdG8gZml4IHRoZSByZWFkIHJlZ2lzdGVyIGlvY3RsIGludGVyZmFjZS4gIFRoZSBy
YXN0ZXIgY29uZmlnIHJlZ2lzdGVycyBjYW4gYmUgcmVhZCBiYWNrIGJ5IHRoZSBVTURzLCBidXQg
aWYgdGhlIEtNRCBoYXNuJ3QgcHJvZ3JhbW1lZCB0aGVtLCB0aGV5IG1heSBoYXZlIGJvZ3VzIHZh
bHVlcy4gIEl0J3MgbWFpbmx5IGZvciB0aGUgcHJvIGRyaXZlcnMgd2hpY2ggcmVhZCB0aGUgcmFz
dGVyIGNvbmZpZyByZWdpc3RlcnMgdG8gZ2V0IHRoZSBiYXNlbGluZSBiZWZvcmUgcHJvZ3JhbW1p
bmcgdGhlbS4gIE1lc2EgaGFyZGNvZGVzIHRoZSBkZWZhdWx0IHJhc3RlciBjb25maWcgc2V0dGlu
Z3MgYmVmb3JlIGhhcnZlc3RpbmcuICBXZSBhcmd1YWJseSBzaG91bGQgaGF2ZSBkb25lIGl0IGlu
IHRoZSBrZXJuZWwgYXMgd2VsbCBmb3IgbWVzYSAobXkgYmFkKS4gIEF0IGxlYXN0IHRoaXMgd2F5
IGJvdGggc2lkZXMgYXJlIGRvaW5nIHRoZSByaWdodCB0aGluZy4NCg0KQWxleA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

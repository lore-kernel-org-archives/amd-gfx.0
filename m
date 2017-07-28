From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/3] drm/amd/powerplay: updated vega10 fan control
Date: Fri, 28 Jul 2017 08:47:43 +0000
Message-ID: <DM5PR1201MB2489D8E33B172D10BE28878EE4BF0@DM5PR1201MB2489.namprd12.prod.outlook.com>
References: <1501228845-21326-1-git-send-email-evan.quan@amd.com>
 <70c33897-ab8a-0a21-0ab5-5534e5e01442@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <70c33897-ab8a-0a21-0ab5-5534e5e01442-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T29wcywgdGhlIGNoYW5nZXMgd2VyZSBtYWRlIGJ5IGEgcmVtb3RlIHdpbmRvd3MgZWRpdG9yIHdo
aWNoIGFkZGVkIHRoZSBleGVjdXRhYmxlIGJpdCB3cm9uZ2x5Lg0KVGhhbmtzIGZvciB0aGUgcmVt
aW5kLiBXaWxsIHBheSBhdHRlbnRpb24gdG8gaXQuDQoNClJlZ2FyZHMsDQpFdmFuDQo+LS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNaWNoZWwgRMOkbnplciBbbWFpbHRvOm1pY2hl
bEBkYWVuemVyLm5ldF0NCj5TZW50OiBGcmlkYXksIEp1bHkgMjgsIDIwMTcgNDozOCBQTQ0KPlRv
OiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NCj5DYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZC9wb3dlcnBsYXk6
IHVwZGF0ZWQgdmVnYTEwIGZhbiBjb250cm9sDQo+DQo+T24gMjgvMDcvMTcgMDU6MDAgUE0sIEV2
YW4gUXVhbiB3cm90ZToNCj4+IENoYW5nZS1JZDogSWZiZWIxZjBjOGUxOTVjYzljYjFlOWNmZjk3
NTI4NGQ5NmQ0OWIxOTMNCj4+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFt
ZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92
ZWdhMTBfdGhlcm1hbC5jIHwgNiArLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDUgZGVsZXRpb25zKC0pDQo+PiAgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NQ0K
PmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF90aGVybWFsLmMNCj4N
Cj5QbGVhc2UgZml4IHlvdXIgc2V0dXAgbm90IHRvIHNldCBleGVjdXRhYmxlIGJpdHMgZm9yIHNv
dXJjZSBjb2RlIGZpbGVzLg0KPg0KPg0KPi0tDQo+RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQ0KPkxpYnJlIHNv
ZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRl
dmVsb3Blcg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH xf86-video-amdgpu] Fix hang when entering into dpms-off
 mode
Date: Fri, 1 Mar 2019 09:03:52 +0000
Message-ID: <DM6PR12MB3611BA38EC65AC14D615C7A3F0760@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <1551322325-19958-1-git-send-email-aaron.liu@amd.com>
 <dd111c99-c1f9-d1d7-5c40-3fcf7b75b1ea@daenzer.net>
 <814ff51d-cde2-8a3e-6755-fd656a900a87@daenzer.net>
 <DM6PR12MB361173B0EF321F8862519D85F0760@DM6PR12MB3611.namprd12.prod.outlook.com>
 <a274ff35-60ba-d735-2656-0508556ad5b1@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a274ff35-60ba-d735-2656-0508556ad5b1-otUistvHUpPR7s880joybQ@public.gmane.org>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDAxLCAyMDE5IDQ6NDMgUE0N
Cj4gVG86IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB4Zjg2LXZpZGVvLWFtZGdw
dV0gRml4IGhhbmcgd2hlbiBlbnRlcmluZyBpbnRvIGRwbXMtDQo+IG9mZiBtb2RlDQo+IA0KPiBP
biAyMDE5LTAzLTAxIDc6MzcgYS5tLiwgTGl1LCBBYXJvbiB3cm90ZToNCj4gPiBATWljaGVsIETD
pG56ZXIsDQo+ID4NCj4gPiBJIGhhdmUgcmV2aWV3ZWQgeW91ciBwYXRjaCBhbmQgdmVyaWZpZWQg
aXQgcGFzc2VkLg0KPiANCj4gVGhhbmtzIEFhcm9uLCBzbyBJIGFzc3VtZSBJIGNhbiBhZGQNCj4g
DQo+IFJldmlld2VkLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KPiBUZXN0ZWQt
Ynk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQo+IA0KPiA/DQpTdXJl8J+Yig0KPiAN
Cj4gDQo+ID4gSSBjb3VsZG4ndCBtZXJnZSB0aGlzIG1lcmdlIHJlcXVlc3QgdG8geW91ciBtYXN0
ZXIgbWFudWFsbHkuDQo+IA0KPiBEb24ndCB3b3JyeSwgSSdsbCBtZXJnZSBpdCB2aWEgdGhlIEdp
dExhYiBtZXJnZSByZXF1ZXN0IFVJLg0KPiANCj4gDQo+IC0tDQo+IEVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIGh0dHBzOi8vd3d3LmFtZC5jb20N
Cj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1l
c2EgYW5kIFggZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=

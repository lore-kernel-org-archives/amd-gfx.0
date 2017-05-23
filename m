From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Tue, 23 May 2017 12:11:35 +0000
Message-ID: <BN6PR12MB1652CDB93556D5F485159606F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1bdcfa4a-6840-796e-1623-2949358a0364-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?J01pY2hlbCBEw6RuemVyJw==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IFttYWlsdG86YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZ10gT24gQmVoYWxmDQo+IE9mIE1pY2hl
bCBEw6RuemVyDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTEsIDIwMTcgODo1MCBQTQ0KPiBUbzog
TGksIFNhbXVlbA0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFl1YW4sIFhp
YW9qaWUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGFtZGdwdTogbW92ZSBhc2ljIGlkIHRh
YmxlIHRvIGEgc2VwYXJhdGUgZmlsZQ0KPiANCj4gT24gMTIvMDUvMTcgMDY6MTMgQU0sIExpLCBT
YW11ZWwgd3JvdGU6DQo+ID4gU3VibWl0dGVkIGEgcmVxdWVzdCB0byBjcmVhdGUgYSBuZXcgcmVw
byBvbiBmcmVlZGVza3RvcC4NCj4gDQo+IFdoYXQncyB0aGUgcG9pbnQgb2YgaGF2aW5nIGEgc2Vw
YXJhdGUgcmVwb3NpdG9yeSB1cHN0cmVhbT8gQ2FuJ3Qgd2UganVzdA0KPiBrZWVwIGl0IGluIHRo
ZSBsaWJkcm0gcmVwb3NpdG9yeT8NCg0KVGhlcmUncyBubyBuZWVkIGZvciBhIHNlcGFyYXRlIHJl
cG8gdXBzdHJlYW0uICBJdCdzIHB1cmVseSB0byBhaWQgaW50ZXJuYWwgcGFja2FnaW5nLg0KDQpB
bGV4DQoNCj4gDQo+IA0KPiAtLQ0KPiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQo+IExpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

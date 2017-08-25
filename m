From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
Date: Fri, 25 Aug 2017 12:59:59 +0000
Message-ID: <BN6PR1201MB01806ACF078801D91460C110859B0@BN6PR1201MB0180.namprd12.prod.outlook.com>
References: <1503511940-645-1-git-send-email-kent.russell@amd.com>
 <1e64a642-411e-ea58-1639-390e4c3cd75d@vodafone.de>
 <BN6PR1201MB01801A32C06AE0DA6634F440859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <CADnq5_PD3s8HHPtr49ZJ3DXPVXgP5xyvFZj_YTzsGCi=cnOUKA@mail.gmail.com>
 <BN6PR1201MB018010027CA78E203F629BA7859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <DM5PR1201MB023503F29269CEC80DC7DAD8929A0@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <CADnq5_Piyp7mtHi+4GZ0pUw1kMNT68ZVyA6jp1TR4VhbCjWAOA@mail.gmail.com>
 <BN6PR1201MB01804846B5629D28766FDFA0859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <fa2dddb4-5ceb-87f3-6305-fb5f6e6e5c2d@vodafone.de>
 <BN6PR1201MB0180502DC4720A3C33D642DB859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <4cec0dad-502e-68f2-68c9-b5d0103d7093@amd.com>
 <BN6PR1201MB01803DD5EBD0049397F4E9F0859B0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <0a3d4d07-e3cd-6216-466b-30bc60c8a26a@vodafone.de>
 <22c4b9e2-67e2-bd0a-1147-6e896843783e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <22c4b9e2-67e2-bd0a-1147-6e896843783e-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhlcmUgaXMgR1BVIFBvd2VyIHVzYWdlIHJlcG9ydGVkIHRocm91Z2ggYW1kZ3B1X3BtX2luZm8s
IHdoaWNoIGFsc28gaGFzIHNvbWUgb3RoZXIgaW5mb3JtYXRpb24gYXMgd2VsbC4gSSdkIGxpa2Ug
dGhhdCBpbiBzeXNmcywgYnV0IEkgYW0gdW5zdXJlIGlmIHdlIGFyZSAgYWxsb3dlZCB0byBkdWUg
dG8gdGhlIG90aGVyIGluZm9ybWF0aW9uIHJlcG9ydGVkIHRoZXJlLg0KDQogS2VudA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU3REZW5pcywgVG9tIA0KU2VudDogRnJpZGF5
LCBBdWd1c3QgMjUsIDIwMTcgODo1OCBBTQ0KVG86IENocmlzdGlhbiBLw7ZuaWc7IFJ1c3NlbGws
IEtlbnQ7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBBZGQgc3lzZnMgZmlsZSBmb3IgVkJJT1MNCg0KT24gMjUvMDgvMTcgMDg6
NTYgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEhpIEtlbnQsDQo+IA0KPiBhZ3JlZSBv
biB0aGUgVkJJT1MgZHVtcCBmaWxlLCB0aGF0IGNsZWFybHkgYmVsb25ncyB0byBkZWJ1Z3NmLg0K
PiANCj4gVGhlIHBvd2VyIHVzYWdlIHN0dWZmIEkgY2FuJ3Qgc2F5IG11Y2ggYWJvdXQgY2F1c2Ug
SSdtIG5vdCBkZWVwbHkgaW50byANCj4gdGhpcywgYnV0IGtlZXAgaW4gbWluZCB0aGUgcmVzdHJp
Y3Rpb24gZm9yIHN5c2ZzOg0KPiAxLiBJdCdzIGEgc3RhYmxlIGludGVyZmFjZS4gU28gaXQgbXVz
dCBiZSB2ZXJ5IHdlbGwgZGVzaWduZWQuDQo+IDIuIE9ubHkgb25lIHZhbHVlIHBlciBmaWxlLiBJ
IHRoaW5rIHRoZSBwb3dlciBzdHVmZiBkb2Vzbid0IGZ1bGZpbGwgDQo+IHRoYXQgcmVxdWlyZW1l
bnQgYXQgdGhlIG1vbWVudC4NCg0KV2hhdCAicG93ZXIiIHN0dWZmIGFyZSB3ZSB0YWxraW5nIGFi
b3V0PyAgVGhlIHNlbnNvcnMgaW50ZXJmYWNlIG9yIHRoZSBwbV9pbmZvIG9yIHNvbWV0aGluZyBl
bHNlPw0KDQpLZWVwIGluIG1pbmQgdW1yIHVzZXMgdGhlIHNlbnNvcnMgZGVidWdmcyBmaWxlIGlu
IC0tdG9wIG1vZGUuDQoNClRvbQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==

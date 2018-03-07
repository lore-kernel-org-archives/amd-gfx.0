From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 11:04:23 +0100
Message-ID: <5a228d74-0c3b-bc70-1c17-215cc2bb6a70@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <3f0a85f6-ac67-cd8c-716e-1c1655d40226@gmail.com>
 <c23ddc4b-c785-be3b-8321-416bb8417b6d@amd.com>
 <CADnq5_OAnM2p2NHnOAduCd+yomFXKqKhrag+JaayZD1Ri9z_2Q@mail.gmail.com>
 <BY1PR12MB05044ACBE8424866B3CCA243F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <55efd18e-296f-fc60-9561-522650847080@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <55efd18e-296f-fc60-9561-522650847080-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDcuMDMuMjAxOCB1bSAxMDo1MyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDMtMDcgMTA6NDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFNlZSB3aGVuIEkgdGVz
dGVkIHRoaXMgdGhlIEREWCBhbmQgTWVzYSB3aGVyZSB1bm1vZGlmaWVkLCBzbyBib3RoIHN0aWxs
Cj4+IGFzc3VtZWQgVlJBTSBhcyBwbGFjZW1lbnQgZm9yIHNjYW5vdXQgQk9zLCBidXQgdGhlIGtl
cm5lbCBmb3JjZWQgc2Nhbm91dAo+PiBCT3MgaW50byBHVFQgZm9yIHRlc3RpbmcuCj4+Cj4+IFNv
IHdoYXQgaGFwcGVuZWQgd2FzIHRoYXQgb24gc2Nhbm91dCB3ZSBtb3ZlZCB0aGUgVlJBTSBCTyB0
byBHVFQgYW5kCj4+IGFmdGVyIHVucGlubmluZyBpdCBvbiB0aGUgZmlyc3QgY29tbWFuZCBzdWJt
aXNzaW9uIHdoaWNoIHVzZWQgdGhlIEJPIHdlCj4+IG1vdmVkIGl0IGJhY2sgdG8gVlJBTSBhZ2Fp
bi4KPj4KPj4gU28gYXMgbG9uZyBhcyB3ZSBkb24ndCB3YW50IGEgc2V2ZXJlIHBlcmZvcm1hbmNl
IHBlbmFsdHkgd2hlbiB5b3UKPj4gY29tYmluZSBvbGQgdXNlcnNwYWNlIHdpdGggbmV3IGtlcm5l
bCB1c2luZyBhIGtlcm5lbCBwYXJhbWV0ZXIgdG8gZm9yY2UKPj4gc2Nhbm91dCBmcm9tIEdUVCBp
cyBub3QgcG9zc2libGUuCj4gVGhhdCBtZWFucyB3ZSBlaXRoZXIgbmVlZCB0byBjb21lIHVwIHdp
dGggYSBkaWZmZXJlbnQgd29ya2Fyb3VuZCBmb3IKPiBoYXJkd2FyZSBpc3N1ZXMgdHJhbnNpdGlv
bmluZyBiZXR3ZWVuIHNjYW5vdXQgZnJvbSBWUkFNIGFuZCBHVFQsIG9yIHdlCj4gY2FuJ3Qgc2Nh
biBvdXQgZnJvbSBHVFQgaW4gdGhhdCBjYXNlLgoKV2hhdCBleGFjdGx5IHdhcyB0aGUgcHJvYmxl
bSB3aXRoIHRoZSB0cmFuc2l0aW9uIGZyb20gVlJBTSB0byBHVFQ/CgpJIG1lYW4gd2hhdCB3ZSBj
YW4gcmF0aGVyIGVhc2lseSBkbyBpcyBjaGVjayB3aGVyZSB0aGUgZXhpc3RpbmcgQk8gaXMgCnBp
bm5lZCBhbmQgdGhlbiBhbHdheXMgcGluIGludG8gdGhlIHNhbWUgZG9tYWluIG9uIHBhZ2UgZmxp
cC4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

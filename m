From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Thu, 8 Mar 2018 10:07:02 +0100
Message-ID: <06e9160c-b4d4-6c3a-ff9f-04b40b94c7a0@amd.com>
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
 <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1b643a78-d86a-b3bf-5f92-089a43201dd5-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMDguMDMuMjAxOCB1bSAwOTozNSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDMtMDcgMTA6NDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDA3LjAzLjIwMTgg
dW0gMDk6NDIgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDMtMDYgMDc6MjMg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pgo+Pj4+IEUuZy4gdGhlIGxhc3QgdGltZSBJ
IHRlc3RlZCBpdCBwbGFjaW5nIHRoaW5ncyBpbnRvIEdUVCBzdGlsbCByZXN1bHRlZAo+Pj4+IGlu
IHF1aXRlIGEgcGVyZm9ybWFuY2UgcGVuYWx0eSBmb3IgcmVuZGVyaW5nLgo+Pj4gRldJVywgSSB0
aGluayB0aGUgcGVuYWx0eSBpcyBtb3N0IGxpa2VseSBJT01NVSByZWxhdGVkLiBMYXN0IHRpbWUg
SQo+Pj4gdGVzdGVkLCBJIGNvdWxkbid0IG1lYXN1cmUgYSBiaWcgZGlmZmVyZW5jZSB3aXRoIElP
TU1VIGRpc2FibGVkLgo+PiBObywgdGhlIHBlbmFsdHkgSSdtIHRhbGtpbmcgYWJvdXQgY2FtZSBm
cm9tIHRoZSBwaW5nL3Bvbmcgd2UgZGlkIHdpdGgKPj4gdGhlIHNjYW5vdXQgYnVmZmVycy4KPj4K
Pj4gU2VlIHdoZW4gSSB0ZXN0ZWQgdGhpcyB0aGUgRERYIGFuZCBNZXNhIHdoZXJlIHVubW9kaWZp
ZWQsIHNvIGJvdGggc3RpbGwKPj4gYXNzdW1lZCBWUkFNIGFzIHBsYWNlbWVudCBmb3Igc2Nhbm91
dCBCT3MsIGJ1dCB0aGUga2VybmVsIGZvcmNlZCBzY2Fub3V0Cj4+IEJPcyBpbnRvIEdUVCBmb3Ig
dGVzdGluZy4KPj4KPj4gU28gd2hhdCBoYXBwZW5lZCB3YXMgdGhhdCBvbiBzY2Fub3V0IHdlIG1v
dmVkIHRoZSBWUkFNIEJPIHRvIEdUVCBhbmQKPj4gYWZ0ZXIgdW5waW5uaW5nIGl0IG9uIHRoZSBm
aXJzdCBjb21tYW5kIHN1Ym1pc3Npb24gd2hpY2ggdXNlZCB0aGUgQk8gd2UKPj4gbW92ZWQgaXQg
YmFjayB0byBWUkFNIGFnYWluLgo+IEluIHRoZSBtZWFudGltZSwgSSd2ZSBoYWQgdGhlIHNhbWUg
aWRlYSBhcyBNYXJlazogQ2FuJ3QgdGhlIGtlcm5lbAo+IGRyaXZlciBzaW1wbHkgY2hhbmdlIHRo
ZSBCTydzIHByZWZlcnJlZCBkb21haW4gdG8gR1RUIHdoZW4gc2Nhbm5pbmcgb3V0Cj4gZnJvbSBp
dD8gVGhlbiBpdCB3b24ndCBtb3ZlIGJhY2sgdG8gVlJBTS4KClllcywgSSd2ZSBjb25zaWRlcmVk
IHRoaXMgYXMgd2VsbC4KCkJ1dCBJIHRoaW5rIG1ha2luZyB0aGUgZGVjaXNpb24gaW4gTWVzYSBp
cyB0aGUgY2xlYW5lciBhcHByb2FjaC4KCkUuZy4gc28gZmFyIHdlIG9ubHkgb3ZlcnJpZGUgdGhl
IHBsYWNlbWVudCBkZWNpc2lvbiBvZiB1c2Vyc3BhY2UgZm9yIHR3byAKcmVhc29uczoKMS4gV2Ug
d2hlcmUgcnVubmluZyBvdXQgb2YgbWVtb3J5IGluIFZSQU0uCjIuIFdlIGhhdmUgYSBoYXJkd2Fy
ZSByZXN0cmljdGlvbiB3aGljaCBtYWtlcyBWUkFNIHVzYWdlIG1hbmRhdG9yeS4KCkFuZCBldmVu
IHRoZW4gd2UgbmV2ZXIgYWRqdXN0IHRoZSBwbGFjZW1lbnQgcGVybWFuZW50bHksIHdlIGp1c3Qg
CnRlbXBvcmFyeSBtb3ZlZCB0aGUgYnVmZmVyIHdoZXJlIGl0IHdhcyBuZWVkZWQgYW5kIG1vdmVk
IGl0IGJhY2sgYWZ0ZXIgCnRoZSBvcGVyYXRpb24gY29tcGxldGVkLgoKQWRkaXRpb25hbCB0byB0
aGF0IE1lc2EgbWlnaHQgd2FudCB0byBzZXQgZXZlbiBtb3JlIGZsYWdzIGFuZC9vciBjaGFuZ2Vz
IAppdCdzIGJlaGF2aW9yLiBFLmcuIHVzZSBhIHRpbGxpbmcgbW9kZSB3aGljaCBib3RoIGltcG9y
dGVyIGFuZCBleHBvcnQgaW4gCmFuIEErQSBsYXB0b3AgdW5kZXJzdGFuZHMgZXRjLi4uCgpSZWdh
cmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

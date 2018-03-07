From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 13:27:45 -0500
Message-ID: <CADnq5_NOVK1sgOwbioVtJ8-syfKthvJ44ifS5X549ZZEEZzUUw@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
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
 <5a228d74-0c3b-bc70-1c17-215cc2bb6a70@amd.com>
 <1ed86df5-1b0d-b409-bb2d-d1c70299ea99@daenzer.net>
 <a3fb9f28-9223-0997-6f4a-419e57a44848@amd.com>
 <CADnq5_NykcGcvNp2q=1Ce68Wuddg6t9i18toB8ntXDFgcTcqDg@mail.gmail.com>
 <436764aa-a11b-24ba-1d81-648eda9d6150@daenzer.net>
 <e70cc3eb-b549-551b-7d31-6adfa3471f8d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e70cc3eb-b549-551b-7d31-6adfa3471f8d-5C7GfCeVMHo@public.gmane.org>
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
To: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBNYXIgNywgMjAxOCBhdCAxOjE4IFBNLCBTYW11ZWwgTGkgPHNhbXVlbC5saUBhbWQu
Y29tPiB3cm90ZToKPiBJIHRoaW5rIGl0J3Mgbm90IHVzZWZ1bCB0aG91Z2guIFRoaW5rIGFib3V0
IHRoYXQsIFNHIGRpc3BsYXkgZmVhdHVyZSBpcyBpbnRlbmRlZCB0byB1c2UgYXMgbGVzcyBWUkFN
IGFzIHBvc3NpYmxlLiBXaWxsIHNvbWVvbmUgd2FudCBhIGRpc3BsYXkgYnVmZmVyIHNvbWV0aW1l
cyBWUkFNLCBzb21ldGltZXMgR1RUPwo+IEhhcmRseSBhIGNhc2UgdG8gbWUsIGFuZCBJIHRoaW5r
IGl0J3MgYSB3YXN0ZSBvZiBlZmZvcnQuIFRoYXQgYWxzbyBtaWdodCBleHBsYWluIG5vIGRyaXZl
ciBkb2VzIHRoYXQgbm93LgoKWW91IG1pZ2h0IHdhbnQgZGlmZmVyZW50IHN0cmF0ZWdpZXMgZGVw
ZW5kaW5nIG9uIGhvdyBtdWNoIFZSQU0geW91CmhhdmUuICBJZiB5b3UgaGF2ZSBhIGJ1bmNoIGFu
ZCBpdCBwZXJmb3JtcyBiZXR0ZXIsIHByZWZlciBpdC4gIElmIHlvdQpoYXZlIGxpbWl0ZWQgVlJB
TSwgeW91IG1pZ2h0IHdhbnQgdG8gcHJlZmVyIEdUVC4gIFlvdSBtaWdodCBhbHNvIHdhbnQKdG8g
cHJlZmVyIFZSQU0sIGJ1dCBhbHNvIGFsbG93IGJ1ZmZlcnMgdG8gZmFsbCBiYWNrIHRvIEdUVCBp
ZgpuZWNlc3NhcnkuICBUaGlzIHdvdWxkIG1ha2UgdGhlIGxvZ2ljIGR5bmFtaWMgYW5kIGFsbCBp
biBvbmUgcGxhY2UuClRoZSBrZXJuZWwgY2FuIGFkdmVydGlzZSB3aGF0IGFzaWNzIHN1cHBvcnQg
c2Nhbm91dCBmcm9tIHN5c3RlbSByYW0KYW5kIHRoZW4gVU1EcyBjYW4ganVzdCBxdWVyeSB0aGF0
IHRvIGNob29zZSBwbGFjZW1lbnRzIHJhdGhlciB0aGFuCmFkZGluZyBoYXJkY29kZWQgbG9naWMg
Zm9yIHNwZWNpZmljIGFzaWNzLgoKQWxleAoKPgo+IFNhbQo+Cj4KPgo+IE9uIDIwMTgtMDMtMDcg
MTI6NTAgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBPbiAyMDE4LTAzLTA3IDA2OjM4IFBN
LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+PiBPbiBXZWQsIE1hciA3LCAyMDE4IGF0IDEyOjI5IFBN
LCBTYW11ZWwgTGkgPHNhbXVlbC5saUBhbWQuY29tPiB3cm90ZToKPj4+Pgo+Pj4+IFdoeSBzbyBj
b21wbGljYXRlZD8gSWYgb2xkIHVzZXIgc3BhY2UgY29tcGF0aWJpbGl0eSBpcyByZXF1aXJlZCwg
anVzdCB1c2Ugc2dfZGlzcGxheT0wLgo+Pj4KPj4+IEl0IHdpbGwgYWx3YXlzIGp1c3Qgd29yayBp
biB0aGF0IGNhc2UgYW5kIHdlIGNhbiBhZGp1c3QgZm9yIHRoZQo+Pj4gb3B0aW1hbCBzY2VuYXJp
byBieSBkZWZhdWx0IGluIGFsbCBjYXNlcyB3aXRob3V0IHJlcXVpcmluZyB0aGUgdXNlciB0bwo+
Pj4gc2V0IG1pc2MgcGFyYW1ldGVycyB0byB0dW5lIHRoZWlyIHNldHVwIHRoYXQgbWF5IGJyZWFr
IGluIHRoZSBmdXR1cmUKPj4+IG9yIGhpZGUgYnVncyBiZWNhdXNlIGEgdXNlciBzZXRzIGl0IGFu
ZCBmb3JnZXRzIGl0Lgo+Pgo+PiBSaWdodC4gSSBkb24ndCBhZ3JlZSBpdCdzIGFsbCB0aGF0IGNv
bXBsaWNhdGVkIGFueXdheSwgd2UgZG8gdGhpcyBzb3J0Cj4+IG9mIHRoaW5nIGFsbCB0aGUgdGlt
ZSwgaXQgYWxzbyBtYWtlcyBvdXIgbGl2ZXMgZWFzaWVyIGRvd24gdGhlIHJvYWQuCj4+Cj4+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

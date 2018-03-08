From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Thu, 8 Mar 2018 09:35:50 +0100
Message-ID: <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1141c511-597e-c81b-6ffd-800ff846f2c1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-CA
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMy0wNyAxMDo0NyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNy4w
My4yMDE4IHVtIDA5OjQyIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDMtMDYg
MDc6MjMgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Cj4+PiBFLmcuIHRoZSBsYXN0IHRp
bWUgSSB0ZXN0ZWQgaXQgcGxhY2luZyB0aGluZ3MgaW50byBHVFQgc3RpbGwgcmVzdWx0ZWQKPj4+
IGluIHF1aXRlIGEgcGVyZm9ybWFuY2UgcGVuYWx0eSBmb3IgcmVuZGVyaW5nLgo+PiBGV0lXLCBJ
IHRoaW5rIHRoZSBwZW5hbHR5IGlzIG1vc3QgbGlrZWx5IElPTU1VIHJlbGF0ZWQuIExhc3QgdGlt
ZSBJCj4+IHRlc3RlZCwgSSBjb3VsZG4ndCBtZWFzdXJlIGEgYmlnIGRpZmZlcmVuY2Ugd2l0aCBJ
T01NVSBkaXNhYmxlZC4KPiAKPiBObywgdGhlIHBlbmFsdHkgSSdtIHRhbGtpbmcgYWJvdXQgY2Ft
ZSBmcm9tIHRoZSBwaW5nL3Bvbmcgd2UgZGlkIHdpdGgKPiB0aGUgc2Nhbm91dCBidWZmZXJzLgo+
IAo+IFNlZSB3aGVuIEkgdGVzdGVkIHRoaXMgdGhlIEREWCBhbmQgTWVzYSB3aGVyZSB1bm1vZGlm
aWVkLCBzbyBib3RoIHN0aWxsCj4gYXNzdW1lZCBWUkFNIGFzIHBsYWNlbWVudCBmb3Igc2Nhbm91
dCBCT3MsIGJ1dCB0aGUga2VybmVsIGZvcmNlZCBzY2Fub3V0Cj4gQk9zIGludG8gR1RUIGZvciB0
ZXN0aW5nLgo+IAo+IFNvIHdoYXQgaGFwcGVuZWQgd2FzIHRoYXQgb24gc2Nhbm91dCB3ZSBtb3Zl
ZCB0aGUgVlJBTSBCTyB0byBHVFQgYW5kCj4gYWZ0ZXIgdW5waW5uaW5nIGl0IG9uIHRoZSBmaXJz
dCBjb21tYW5kIHN1Ym1pc3Npb24gd2hpY2ggdXNlZCB0aGUgQk8gd2UKPiBtb3ZlZCBpdCBiYWNr
IHRvIFZSQU0gYWdhaW4uCgpJbiB0aGUgbWVhbnRpbWUsIEkndmUgaGFkIHRoZSBzYW1lIGlkZWEg
YXMgTWFyZWs6IENhbid0IHRoZSBrZXJuZWwKZHJpdmVyIHNpbXBseSBjaGFuZ2UgdGhlIEJPJ3Mg
cHJlZmVycmVkIGRvbWFpbiB0byBHVFQgd2hlbiBzY2FubmluZyBvdXQKZnJvbSBpdD8gVGhlbiBp
dCB3b24ndCBtb3ZlIGJhY2sgdG8gVlJBTS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

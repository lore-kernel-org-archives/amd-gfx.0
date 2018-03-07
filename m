From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 12:29:25 -0500
Message-ID: <a3fb9f28-9223-0997-6f4a-419e57a44848@amd.com>
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
 <5a228d74-0c3b-bc70-1c17-215cc2bb6a70@amd.com>
 <1ed86df5-1b0d-b409-bb2d-d1c70299ea99@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1ed86df5-1b0d-b409-bb2d-d1c70299ea99-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CldoeSBzbyBjb21wbGljYXRlZD8gSWYgb2xkIHVzZXIgc3BhY2UgY29tcGF0aWJpbGl0eSBpcyBy
ZXF1aXJlZCwganVzdCB1c2Ugc2dfZGlzcGxheT0wLgoKU2FtCgoKT24gMjAxOC0wMy0wNyAwNTox
MiBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0wMy0wNyAxMTowNCBBTSwgQ2hy
aXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDcuMDMuMjAxOCB1bSAxMDo1MyBzY2hyaWViIE1p
Y2hlbCBEw6RuemVyOgo+Pj4gT24gMjAxOC0wMy0wNyAxMDo0NyBBTSwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPj4+PiBTZWUgd2hlbiBJIHRlc3RlZCB0aGlzIHRoZSBERFggYW5kIE1lc2Egd2hl
cmUgdW5tb2RpZmllZCwgc28gYm90aCBzdGlsbAo+Pj4+IGFzc3VtZWQgVlJBTSBhcyBwbGFjZW1l
bnQgZm9yIHNjYW5vdXQgQk9zLCBidXQgdGhlIGtlcm5lbCBmb3JjZWQgc2Nhbm91dAo+Pj4+IEJP
cyBpbnRvIEdUVCBmb3IgdGVzdGluZy4KPj4+Pgo+Pj4+IFNvIHdoYXQgaGFwcGVuZWQgd2FzIHRo
YXQgb24gc2Nhbm91dCB3ZSBtb3ZlZCB0aGUgVlJBTSBCTyB0byBHVFQgYW5kCj4+Pj4gYWZ0ZXIg
dW5waW5uaW5nIGl0IG9uIHRoZSBmaXJzdCBjb21tYW5kIHN1Ym1pc3Npb24gd2hpY2ggdXNlZCB0
aGUgQk8gd2UKPj4+PiBtb3ZlZCBpdCBiYWNrIHRvIFZSQU0gYWdhaW4uCj4+Pj4KPj4+PiBTbyBh
cyBsb25nIGFzIHdlIGRvbid0IHdhbnQgYSBzZXZlcmUgcGVyZm9ybWFuY2UgcGVuYWx0eSB3aGVu
IHlvdQo+Pj4+IGNvbWJpbmUgb2xkIHVzZXJzcGFjZSB3aXRoIG5ldyBrZXJuZWwgdXNpbmcgYSBr
ZXJuZWwgcGFyYW1ldGVyIHRvIGZvcmNlCj4+Pj4gc2Nhbm91dCBmcm9tIEdUVCBpcyBub3QgcG9z
c2libGUuCj4+PiBUaGF0IG1lYW5zIHdlIGVpdGhlciBuZWVkIHRvIGNvbWUgdXAgd2l0aCBhIGRp
ZmZlcmVudCB3b3JrYXJvdW5kIGZvcgo+Pj4gaGFyZHdhcmUgaXNzdWVzIHRyYW5zaXRpb25pbmcg
YmV0d2VlbiBzY2Fub3V0IGZyb20gVlJBTSBhbmQgR1RULCBvciB3ZQo+Pj4gY2FuJ3Qgc2NhbiBv
dXQgZnJvbSBHVFQgaW4gdGhhdCBjYXNlLgo+Pgo+PiBXaGF0IGV4YWN0bHkgd2FzIHRoZSBwcm9i
bGVtIHdpdGggdGhlIHRyYW5zaXRpb24gZnJvbSBWUkFNIHRvIEdUVD8KPj4KPj4gSSBtZWFuIHdo
YXQgd2UgY2FuIHJhdGhlciBlYXNpbHkgZG8gaXMgY2hlY2sgd2hlcmUgdGhlIGV4aXN0aW5nIEJP
IGlzCj4+IHBpbm5lZCBhbmQgdGhlbiBhbHdheXMgcGluIGludG8gdGhlIHNhbWUgZG9tYWluIG9u
IHBhZ2UgZmxpcC4KPiAKPiBZZWFoLCBzb21ldGhpbmcgbGlrZSB0aGF0IGNvdWxkIHdvcmsuIElu
IHdoaWNoIGNhc2UsIGFsbCB0aGF0J3MgbmVlZGVkCj4gaXMgYSB3YXkgZm9yIHVzZXJzcGFjZSB0
byBrbm93IHRoYXQgR1RUIHNjYW5vdXQgY2FuIHdvcmssIHJpZ2h0PyBXaXRoCj4gdGhhdCBpbmZv
cm1hdGlvbiwgaXQgY2FuIG1hbmFnZSB0aGUgZG9tYWlucyBvZiBzY2Fub3V0IEJPcyBhcyBpdCB3
YW50cy4KPiAKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

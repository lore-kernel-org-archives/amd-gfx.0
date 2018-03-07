From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 11:12:58 +0100
Message-ID: <1ed86df5-1b0d-b409-bb2d-d1c70299ea99@daenzer.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5a228d74-0c3b-bc70-1c17-215cc2bb6a70-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMy0wNyAxMTowNCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNy4w
My4yMDE4IHVtIDEwOjUzIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDMtMDcg
MTA6NDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBTZWUgd2hlbiBJIHRlc3RlZCB0
aGlzIHRoZSBERFggYW5kIE1lc2Egd2hlcmUgdW5tb2RpZmllZCwgc28gYm90aCBzdGlsbAo+Pj4g
YXNzdW1lZCBWUkFNIGFzIHBsYWNlbWVudCBmb3Igc2Nhbm91dCBCT3MsIGJ1dCB0aGUga2VybmVs
IGZvcmNlZCBzY2Fub3V0Cj4+PiBCT3MgaW50byBHVFQgZm9yIHRlc3RpbmcuCj4+Pgo+Pj4gU28g
d2hhdCBoYXBwZW5lZCB3YXMgdGhhdCBvbiBzY2Fub3V0IHdlIG1vdmVkIHRoZSBWUkFNIEJPIHRv
IEdUVCBhbmQKPj4+IGFmdGVyIHVucGlubmluZyBpdCBvbiB0aGUgZmlyc3QgY29tbWFuZCBzdWJt
aXNzaW9uIHdoaWNoIHVzZWQgdGhlIEJPIHdlCj4+PiBtb3ZlZCBpdCBiYWNrIHRvIFZSQU0gYWdh
aW4uCj4+Pgo+Pj4gU28gYXMgbG9uZyBhcyB3ZSBkb24ndCB3YW50IGEgc2V2ZXJlIHBlcmZvcm1h
bmNlIHBlbmFsdHkgd2hlbiB5b3UKPj4+IGNvbWJpbmUgb2xkIHVzZXJzcGFjZSB3aXRoIG5ldyBr
ZXJuZWwgdXNpbmcgYSBrZXJuZWwgcGFyYW1ldGVyIHRvIGZvcmNlCj4+PiBzY2Fub3V0IGZyb20g
R1RUIGlzIG5vdCBwb3NzaWJsZS4KPj4gVGhhdCBtZWFucyB3ZSBlaXRoZXIgbmVlZCB0byBjb21l
IHVwIHdpdGggYSBkaWZmZXJlbnQgd29ya2Fyb3VuZCBmb3IKPj4gaGFyZHdhcmUgaXNzdWVzIHRy
YW5zaXRpb25pbmcgYmV0d2VlbiBzY2Fub3V0IGZyb20gVlJBTSBhbmQgR1RULCBvciB3ZQo+PiBj
YW4ndCBzY2FuIG91dCBmcm9tIEdUVCBpbiB0aGF0IGNhc2UuCj4gCj4gV2hhdCBleGFjdGx5IHdh
cyB0aGUgcHJvYmxlbSB3aXRoIHRoZSB0cmFuc2l0aW9uIGZyb20gVlJBTSB0byBHVFQ/Cj4gCj4g
SSBtZWFuIHdoYXQgd2UgY2FuIHJhdGhlciBlYXNpbHkgZG8gaXMgY2hlY2sgd2hlcmUgdGhlIGV4
aXN0aW5nIEJPIGlzCj4gcGlubmVkIGFuZCB0aGVuIGFsd2F5cyBwaW4gaW50byB0aGUgc2FtZSBk
b21haW4gb24gcGFnZSBmbGlwLgoKWWVhaCwgc29tZXRoaW5nIGxpa2UgdGhhdCBjb3VsZCB3b3Jr
LiBJbiB3aGljaCBjYXNlLCBhbGwgdGhhdCdzIG5lZWRlZAppcyBhIHdheSBmb3IgdXNlcnNwYWNl
IHRvIGtub3cgdGhhdCBHVFQgc2Nhbm91dCBjYW4gd29yaywgcmlnaHQ/IFdpdGgKdGhhdCBpbmZv
cm1hdGlvbiwgaXQgY2FuIG1hbmFnZSB0aGUgZG9tYWlucyBvZiBzY2Fub3V0IEJPcyBhcyBpdCB3
YW50cy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

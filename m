From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 12:38:19 -0500
Message-ID: <CADnq5_NykcGcvNp2q=1Ce68Wuddg6t9i18toB8ntXDFgcTcqDg@mail.gmail.com>
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
 <a3fb9f28-9223-0997-6f4a-419e57a44848@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3fb9f28-9223-0997-6f4a-419e57a44848-5C7GfCeVMHo@public.gmane.org>
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

T24gV2VkLCBNYXIgNywgMjAxOCBhdCAxMjoyOSBQTSwgU2FtdWVsIExpIDxzYW11ZWwubGlAYW1k
LmNvbT4gd3JvdGU6Cj4KPiBXaHkgc28gY29tcGxpY2F0ZWQ/IElmIG9sZCB1c2VyIHNwYWNlIGNv
bXBhdGliaWxpdHkgaXMgcmVxdWlyZWQsIGp1c3QgdXNlIHNnX2Rpc3BsYXk9MC4KCkl0IHdpbGwg
YWx3YXlzIGp1c3Qgd29yayBpbiB0aGF0IGNhc2UgYW5kIHdlIGNhbiBhZGp1c3QgZm9yIHRoZQpv
cHRpbWFsIHNjZW5hcmlvIGJ5IGRlZmF1bHQgaW4gYWxsIGNhc2VzIHdpdGhvdXQgcmVxdWlyaW5n
IHRoZSB1c2VyIHRvCnNldCBtaXNjIHBhcmFtZXRlcnMgdG8gdHVuZSB0aGVpciBzZXR1cCB0aGF0
IG1heSBicmVhayBpbiB0aGUgZnV0dXJlCm9yIGhpZGUgYnVncyBiZWNhdXNlIGEgdXNlciBzZXRz
IGl0IGFuZCBmb3JnZXRzIGl0LgoKQWxleAoKPgo+IFNhbQo+Cj4KPiBPbiAyMDE4LTAzLTA3IDA1
OjEyIEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMjAxOC0wMy0wNyAxMTowNCBBTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDA3LjAzLjIwMTggdW0gMTA6NTMgc2Nocmll
YiBNaWNoZWwgRMOkbnplcjoKPj4+PiBPbiAyMDE4LTAzLTA3IDEwOjQ3IEFNLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+Pj4+PiBTZWUgd2hlbiBJIHRlc3RlZCB0aGlzIHRoZSBERFggYW5kIE1l
c2Egd2hlcmUgdW5tb2RpZmllZCwgc28gYm90aCBzdGlsbAo+Pj4+PiBhc3N1bWVkIFZSQU0gYXMg
cGxhY2VtZW50IGZvciBzY2Fub3V0IEJPcywgYnV0IHRoZSBrZXJuZWwgZm9yY2VkIHNjYW5vdXQK
Pj4+Pj4gQk9zIGludG8gR1RUIGZvciB0ZXN0aW5nLgo+Pj4+Pgo+Pj4+PiBTbyB3aGF0IGhhcHBl
bmVkIHdhcyB0aGF0IG9uIHNjYW5vdXQgd2UgbW92ZWQgdGhlIFZSQU0gQk8gdG8gR1RUIGFuZAo+
Pj4+PiBhZnRlciB1bnBpbm5pbmcgaXQgb24gdGhlIGZpcnN0IGNvbW1hbmQgc3VibWlzc2lvbiB3
aGljaCB1c2VkIHRoZSBCTyB3ZQo+Pj4+PiBtb3ZlZCBpdCBiYWNrIHRvIFZSQU0gYWdhaW4uCj4+
Pj4+Cj4+Pj4+IFNvIGFzIGxvbmcgYXMgd2UgZG9uJ3Qgd2FudCBhIHNldmVyZSBwZXJmb3JtYW5j
ZSBwZW5hbHR5IHdoZW4geW91Cj4+Pj4+IGNvbWJpbmUgb2xkIHVzZXJzcGFjZSB3aXRoIG5ldyBr
ZXJuZWwgdXNpbmcgYSBrZXJuZWwgcGFyYW1ldGVyIHRvIGZvcmNlCj4+Pj4+IHNjYW5vdXQgZnJv
bSBHVFQgaXMgbm90IHBvc3NpYmxlLgo+Pj4+IFRoYXQgbWVhbnMgd2UgZWl0aGVyIG5lZWQgdG8g
Y29tZSB1cCB3aXRoIGEgZGlmZmVyZW50IHdvcmthcm91bmQgZm9yCj4+Pj4gaGFyZHdhcmUgaXNz
dWVzIHRyYW5zaXRpb25pbmcgYmV0d2VlbiBzY2Fub3V0IGZyb20gVlJBTSBhbmQgR1RULCBvciB3
ZQo+Pj4+IGNhbid0IHNjYW4gb3V0IGZyb20gR1RUIGluIHRoYXQgY2FzZS4KPj4+Cj4+PiBXaGF0
IGV4YWN0bHkgd2FzIHRoZSBwcm9ibGVtIHdpdGggdGhlIHRyYW5zaXRpb24gZnJvbSBWUkFNIHRv
IEdUVD8KPj4+Cj4+PiBJIG1lYW4gd2hhdCB3ZSBjYW4gcmF0aGVyIGVhc2lseSBkbyBpcyBjaGVj
ayB3aGVyZSB0aGUgZXhpc3RpbmcgQk8gaXMKPj4+IHBpbm5lZCBhbmQgdGhlbiBhbHdheXMgcGlu
IGludG8gdGhlIHNhbWUgZG9tYWluIG9uIHBhZ2UgZmxpcC4KPj4KPj4gWWVhaCwgc29tZXRoaW5n
IGxpa2UgdGhhdCBjb3VsZCB3b3JrLiBJbiB3aGljaCBjYXNlLCBhbGwgdGhhdCdzIG5lZWRlZAo+
PiBpcyBhIHdheSBmb3IgdXNlcnNwYWNlIHRvIGtub3cgdGhhdCBHVFQgc2Nhbm91dCBjYW4gd29y
aywgcmlnaHQ/IFdpdGgKPj4gdGhhdCBpbmZvcm1hdGlvbiwgaXQgY2FuIG1hbmFnZSB0aGUgZG9t
YWlucyBvZiBzY2Fub3V0IEJPcyBhcyBpdCB3YW50cy4KPj4KPj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

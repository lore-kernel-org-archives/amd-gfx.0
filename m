From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 10:53:32 +0100
Message-ID: <55efd18e-296f-fc60-9561-522650847080@daenzer.net>
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

T24gMjAxOC0wMy0wNyAxMDo0NyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiAKPiBTZWUg
d2hlbiBJIHRlc3RlZCB0aGlzIHRoZSBERFggYW5kIE1lc2Egd2hlcmUgdW5tb2RpZmllZCwgc28g
Ym90aCBzdGlsbAo+IGFzc3VtZWQgVlJBTSBhcyBwbGFjZW1lbnQgZm9yIHNjYW5vdXQgQk9zLCBi
dXQgdGhlIGtlcm5lbCBmb3JjZWQgc2Nhbm91dAo+IEJPcyBpbnRvIEdUVCBmb3IgdGVzdGluZy4K
PiAKPiBTbyB3aGF0IGhhcHBlbmVkIHdhcyB0aGF0IG9uIHNjYW5vdXQgd2UgbW92ZWQgdGhlIFZS
QU0gQk8gdG8gR1RUIGFuZAo+IGFmdGVyIHVucGlubmluZyBpdCBvbiB0aGUgZmlyc3QgY29tbWFu
ZCBzdWJtaXNzaW9uIHdoaWNoIHVzZWQgdGhlIEJPIHdlCj4gbW92ZWQgaXQgYmFjayB0byBWUkFN
IGFnYWluLgo+IAo+IFNvIGFzIGxvbmcgYXMgd2UgZG9uJ3Qgd2FudCBhIHNldmVyZSBwZXJmb3Jt
YW5jZSBwZW5hbHR5IHdoZW4geW91Cj4gY29tYmluZSBvbGQgdXNlcnNwYWNlIHdpdGggbmV3IGtl
cm5lbCB1c2luZyBhIGtlcm5lbCBwYXJhbWV0ZXIgdG8gZm9yY2UKPiBzY2Fub3V0IGZyb20gR1RU
IGlzIG5vdCBwb3NzaWJsZS4KClRoYXQgbWVhbnMgd2UgZWl0aGVyIG5lZWQgdG8gY29tZSB1cCB3
aXRoIGEgZGlmZmVyZW50IHdvcmthcm91bmQgZm9yCmhhcmR3YXJlIGlzc3VlcyB0cmFuc2l0aW9u
aW5nIGJldHdlZW4gc2Nhbm91dCBmcm9tIFZSQU0gYW5kIEdUVCwgb3Igd2UKY2FuJ3Qgc2NhbiBv
dXQgZnJvbSBHVFQgaW4gdGhhdCBjYXNlLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNv
ZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRl
dmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

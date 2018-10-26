From: "Agrawal, Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/powerplay: Enable/Disable NBPSTATE on
 On/OFF of UVD"
Date: Fri, 26 Oct 2018 03:11:40 +0000
Message-ID: <b651b31a-4f0f-3ad3-a3d4-80e5772de7ac@amd.com>
References: <1540484844-31056-1-git-send-email-shirish.s@amd.com>
 <CADnq5_PHg9re4FrfptZjqp60hDreEmjX0xd=tgVB1AHJmSaqvQ@mail.gmail.com>
 <279a5ecb-4c54-916e-d3a4-0fa2d0fc6418@amd.com>
 <CADnq5_P9KON_cyuAhre9XLmCnw5gfUdT5Y9oo=jdreybCrSMRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P9KON_cyuAhre9XLmCnw5gfUdT5Y9oo=jdreybCrSMRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <95FEA1D47E91EE49B3E04D960FCECB60-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

DQoNCk9uIDEwLzI2LzIwMTggODozNCBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBUaHUs
IE9jdCAyNSwgMjAxOCBhdCAxMDo1MiBQTSBBZ3Jhd2FsLCBBa3NodSA8QWtzaHUuQWdyYXdhbEBh
bWQuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDEwLzI2LzIwMTggODowOSBBTSwgQWxl
eCBEZXVjaGVyIHdyb3RlOg0KPj4+IE9uIFRodSwgT2N0IDI1LCAyMDE4IGF0IDEyOjI3IFBNIFMs
IFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gVGhpcyByZXZl
cnRzIGNvbW1pdCBkYmQ4Mjk5YzMyZjZmNDEzZjZjZmUzMjJmZTAzMDhmM2NmYzU3N2U4Lg0KPj4+
Pg0KPj4+PiBSZWFzb24gZm9yIHJldmVydDoNCj4+Pj4gVGhpcyBwYXRjaCBzZW5kcyAgbXNnIFBQ
U01DX01TR19EaXNhYmxlTG93TWVtb3J5UHN0YXRlKDB4MDAyZSkNCj4+Pj4gaW4gd3Jvbmcgb2Yg
c2VxdWVuY2UgdG8gU01VIHdoaWNoIGlzIGJlZm9yZSBQUFNNQ19NU0dfVVZEUG93ZXJPTiAoMHgw
MDA4KS4NCj4+Pj4gVGhpcyBsZWFkcyB0byBTTVUgZmFpbGluZyB0byBzZXJ2aWNlIHRoZSByZXF1
ZXN0IGFzIGl0IGlzDQo+Pj4+IGRlcGVuZGVudCBvbiBVVkQgdG8gYmUgcG93ZXJlZCBPTiwgc2lu
Y2UgaXQgYWNjZXNzZXMgVVZEDQo+Pj4+IHJlZ2lzdGVycy4NCj4+Pg0KPj4+IERvZXMgdGhpcyBw
YXRjaCB0aGF0IGlzIGJlaW5nIHJldmVydGVkIGFjdHVhbGx5IGJyZWFrIHNvbWV0aGluZyBvciBp
cw0KPj4+IGl0IG9rIHRvIGxlYXZlIGFzIGEgd29ya2Fyb3VuZD8gIEl0IHN1cHBvc2VkbHkgZml4
ZWQgZGlzcGxheSBpc3N1ZXMgYXQNCj4+PiA0ayB3aXRoIHZpZGVvLiAgUmV2ZXJ0aW5nIGl0IHdp
bGwgYnJpbmcgdGhhdCBiYWNrIHdvbid0IGl0Pw0KPj4+DQo+Pj4gQWxleA0KPj4+DQo+PiBZZXMg
QWxleCwgaXQgd2lsbCBicmVhayA0ayB2aWRlbyBhcyB0aGVyZSB3aWxsIGJlIHVuZGVycnVuLiBC
dXQgd2UgYXJlDQo+PiB3b3JraW5nIG9uIHBhdGNoZXMgdGhhdCB3aWxsIERpc2FibGUgbWVtb3J5
IE5CUHN0YXRlIG9ubHkgZm9yIDRrIHZpZGVvcy4NCj4+IFdlIGNhbiBoYXZlIHRoaXMgcGF0Y2gg
aW4gYW5kIHdpbGwgYmUgcG9zdGluZyBjb3VwbGUgb2YgcGF0Y2hlcyB0byBmaXgNCj4+IDRrIHZp
ZGVvcyBkaXNwbGF5IGlzc3Vlcy4NCj4gDQo+IENhbiB3ZSBsYW5kIHRoZW0gYWxsIHRvZ2V0aGVy
PyAgT3RoZXJ3aXNlLCB3ZSdsbCBoYXZlIGEgcmVncmVzc2VkDQo+IHN0YXRlIHVudGlsIHRoZSBs
YXRlciBmaXhlcyBsYW5kLg0KPiANCj4gQWxleA0KPiANCkFncmVlZCwgd2lsbCBwdXNoIHRoZW0g
YXMgYSBzZXJpZXMuDQoNClRoYW5rcywNCkFrc2h1DQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK

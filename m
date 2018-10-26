From: "Agrawal, Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/powerplay: Enable/Disable NBPSTATE on
 On/OFF of UVD"
Date: Fri, 26 Oct 2018 02:52:54 +0000
Message-ID: <279a5ecb-4c54-916e-d3a4-0fa2d0fc6418@amd.com>
References: <1540484844-31056-1-git-send-email-shirish.s@amd.com>
 <CADnq5_PHg9re4FrfptZjqp60hDreEmjX0xd=tgVB1AHJmSaqvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PHg9re4FrfptZjqp60hDreEmjX0xd=tgVB1AHJmSaqvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <2CED93DFD19A8A40898EA2A8B7B52D03-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQoNCk9uIDEwLzI2LzIwMTggODowOSBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBUaHUs
IE9jdCAyNSwgMjAxOCBhdCAxMjoyNyBQTSBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gVGhpcyByZXZlcnRzIGNvbW1pdCBkYmQ4Mjk5YzMyZjZmNDEzZjZjZmUz
MjJmZTAzMDhmM2NmYzU3N2U4Lg0KPj4NCj4+IFJlYXNvbiBmb3IgcmV2ZXJ0Og0KPj4gVGhpcyBw
YXRjaCBzZW5kcyAgbXNnIFBQU01DX01TR19EaXNhYmxlTG93TWVtb3J5UHN0YXRlKDB4MDAyZSkN
Cj4+IGluIHdyb25nIG9mIHNlcXVlbmNlIHRvIFNNVSB3aGljaCBpcyBiZWZvcmUgUFBTTUNfTVNH
X1VWRFBvd2VyT04gKDB4MDAwOCkuDQo+PiBUaGlzIGxlYWRzIHRvIFNNVSBmYWlsaW5nIHRvIHNl
cnZpY2UgdGhlIHJlcXVlc3QgYXMgaXQgaXMNCj4+IGRlcGVuZGVudCBvbiBVVkQgdG8gYmUgcG93
ZXJlZCBPTiwgc2luY2UgaXQgYWNjZXNzZXMgVVZEDQo+PiByZWdpc3RlcnMuDQo+IA0KPiBEb2Vz
IHRoaXMgcGF0Y2ggdGhhdCBpcyBiZWluZyByZXZlcnRlZCBhY3R1YWxseSBicmVhayBzb21ldGhp
bmcgb3IgaXMNCj4gaXQgb2sgdG8gbGVhdmUgYXMgYSB3b3JrYXJvdW5kPyAgSXQgc3VwcG9zZWRs
eSBmaXhlZCBkaXNwbGF5IGlzc3VlcyBhdA0KPiA0ayB3aXRoIHZpZGVvLiAgUmV2ZXJ0aW5nIGl0
IHdpbGwgYnJpbmcgdGhhdCBiYWNrIHdvbid0IGl0Pw0KPiANCj4gQWxleA0KPg0KWWVzIEFsZXgs
IGl0IHdpbGwgYnJlYWsgNGsgdmlkZW8gYXMgdGhlcmUgd2lsbCBiZSB1bmRlcnJ1bi4gQnV0IHdl
IGFyZQ0Kd29ya2luZyBvbiBwYXRjaGVzIHRoYXQgd2lsbCBEaXNhYmxlIG1lbW9yeSBOQlBzdGF0
ZSBvbmx5IGZvciA0ayB2aWRlb3MuDQpXZSBjYW4gaGF2ZSB0aGlzIHBhdGNoIGluIGFuZCB3aWxs
IGJlIHBvc3RpbmcgY291cGxlIG9mIHBhdGNoZXMgdG8gZml4DQo0ayB2aWRlb3MgZGlzcGxheSBp
c3N1ZXMuDQoNClRoYW5rcywNCkFrc2h1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK

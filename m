From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/powerplay: Enable/Disable NBPSTATE on
 On/OFF of UVD"
Date: Thu, 25 Oct 2018 23:04:03 -0400
Message-ID: <CADnq5_P9KON_cyuAhre9XLmCnw5gfUdT5Y9oo=jdreybCrSMRg@mail.gmail.com>
References: <1540484844-31056-1-git-send-email-shirish.s@amd.com>
 <CADnq5_PHg9re4FrfptZjqp60hDreEmjX0xd=tgVB1AHJmSaqvQ@mail.gmail.com>
 <279a5ecb-4c54-916e-d3a4-0fa2d0fc6418@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <279a5ecb-4c54-916e-d3a4-0fa2d0fc6418-5C7GfCeVMHo@public.gmane.org>
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
To: Akshu Agrawal <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBPY3QgMjUsIDIwMTggYXQgMTA6NTIgUE0gQWdyYXdhbCwgQWtzaHUgPEFrc2h1LkFn
cmF3YWxAYW1kLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMTAvMjYvMjAxOCA4OjA5IEFNLCBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gPiBPbiBUaHUsIE9jdCAyNSwgMjAxOCBhdCAxMjoyNyBQTSBTLCBT
aGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBUaGlzIHJldmVydHMg
Y29tbWl0IGRiZDgyOTljMzJmNmY0MTNmNmNmZTMyMmZlMDMwOGYzY2ZjNTc3ZTguCj4gPj4KPiA+
PiBSZWFzb24gZm9yIHJldmVydDoKPiA+PiBUaGlzIHBhdGNoIHNlbmRzICBtc2cgUFBTTUNfTVNH
X0Rpc2FibGVMb3dNZW1vcnlQc3RhdGUoMHgwMDJlKQo+ID4+IGluIHdyb25nIG9mIHNlcXVlbmNl
IHRvIFNNVSB3aGljaCBpcyBiZWZvcmUgUFBTTUNfTVNHX1VWRFBvd2VyT04gKDB4MDAwOCkuCj4g
Pj4gVGhpcyBsZWFkcyB0byBTTVUgZmFpbGluZyB0byBzZXJ2aWNlIHRoZSByZXF1ZXN0IGFzIGl0
IGlzCj4gPj4gZGVwZW5kZW50IG9uIFVWRCB0byBiZSBwb3dlcmVkIE9OLCBzaW5jZSBpdCBhY2Nl
c3NlcyBVVkQKPiA+PiByZWdpc3RlcnMuCj4gPgo+ID4gRG9lcyB0aGlzIHBhdGNoIHRoYXQgaXMg
YmVpbmcgcmV2ZXJ0ZWQgYWN0dWFsbHkgYnJlYWsgc29tZXRoaW5nIG9yIGlzCj4gPiBpdCBvayB0
byBsZWF2ZSBhcyBhIHdvcmthcm91bmQ/ICBJdCBzdXBwb3NlZGx5IGZpeGVkIGRpc3BsYXkgaXNz
dWVzIGF0Cj4gPiA0ayB3aXRoIHZpZGVvLiAgUmV2ZXJ0aW5nIGl0IHdpbGwgYnJpbmcgdGhhdCBi
YWNrIHdvbid0IGl0Pwo+ID4KPiA+IEFsZXgKPiA+Cj4gWWVzIEFsZXgsIGl0IHdpbGwgYnJlYWsg
NGsgdmlkZW8gYXMgdGhlcmUgd2lsbCBiZSB1bmRlcnJ1bi4gQnV0IHdlIGFyZQo+IHdvcmtpbmcg
b24gcGF0Y2hlcyB0aGF0IHdpbGwgRGlzYWJsZSBtZW1vcnkgTkJQc3RhdGUgb25seSBmb3IgNGsg
dmlkZW9zLgo+IFdlIGNhbiBoYXZlIHRoaXMgcGF0Y2ggaW4gYW5kIHdpbGwgYmUgcG9zdGluZyBj
b3VwbGUgb2YgcGF0Y2hlcyB0byBmaXgKPiA0ayB2aWRlb3MgZGlzcGxheSBpc3N1ZXMuCgpDYW4g
d2UgbGFuZCB0aGVtIGFsbCB0b2dldGhlcj8gIE90aGVyd2lzZSwgd2UnbGwgaGF2ZSBhIHJlZ3Jl
c3NlZApzdGF0ZSB1bnRpbCB0aGUgbGF0ZXIgZml4ZXMgbGFuZC4KCkFsZXgKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

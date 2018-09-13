From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources statically
Date: Thu, 13 Sep 2018 17:01:08 -0400
Message-ID: <CAAxE2A5e6Rx_eZc40E=5ow+qwrkd2RoOFPbPBHBz3wCi3rusAg@mail.gmail.com>
References: <20180912203358.2172-1-maraeo@gmail.com>
 <904d7dbb-eeec-03a0-92c8-5c5170a7b43c@gmail.com>
 <CAAxE2A44Brp==LORVMuKkU7o+O4wGiBEx7T8yYyMZd_b2uh6Tw@mail.gmail.com>
 <7db280c8-e013-6865-aef7-7c1d5640b875@amd.com>
 <CAAxE2A64kojhUe+drdccAkSE4kTZP94OyMmG+xqH9wdDYgKATg@mail.gmail.com>
 <BN6PR12MB180977B44E93B5357C5145B3F71A0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A7Wd9wwQL-43eFi8wjs+oD6-cHWR95nM1U44_yJP6Q4YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7Wd9wwQL-43eFi8wjs+oD6-cHWR95nM1U44_yJP6Q4YA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VG8gYmUgZmFpciwgc2luY2Ugd2UgaGF2ZSBvbmx5IDcgdXNlciBWTUlEcyBhbmQgOCBjaHVua3Mg
b2YgR0RTLCB3ZQpjYW4gbWFrZSB0aGUgOHRoIEdEUyBjaHVuayBnbG9iYWwgYW5kIGFsbG9jYXRh
YmxlIGFuZCB1c2UgaXQgYmFzZWQgb24KYSBDUyBmbGFnLiBJdCB3b3VsZCBuZWVkIG1vcmUgd29y
ayBhbmQgYSBsb3Qgb2YgdGVzdGluZyB0aG91Z2guIEkKZG9uJ3QgdGhpbmsgd2UgY2FuIGRvIHRo
ZSB0ZXN0aW5nIHBhcnQgbm93IGJlY2F1c2Ugb2YgdGhlIGNvbXBsZXhpdHkKb2YgaW50ZXJhY3Rp
b25zIGJldHdlZW4gcGVyLVZNSUQgR0RTIGFuZCBnbG9iYWwgR0RTLCBidXQgaXQncwpjZXJ0YWlu
bHkgc29tZXRoaW5nIHRoYXQgcGVvcGxlIGNvdWxkIGFkZCBpbiB0aGUgZnV0dXJlLgoKTWFyZWsK
Ck9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDM6MDQgUE0sIE1hcmVrIE9sxaHDoWsgPG1hcmFlb0Bn
bWFpbC5jb20+IHdyb3RlOgo+IEkgd2FzIHRoaW5raW5nIGFib3V0IHRoYXQgdG9vLCBidXQgaXQg
d291bGQgYmUgdG9vIG11Y2ggdHJvdWJsZSBmb3IKPiBzb21ldGhpbmcgd2UgZG9uJ3QgbmVlZC4K
Pgo+IE1hcmVrCj4KPiBPbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAyOjU3IFBNLCBEZXVjaGVyLCBB
bGV4YW5kZXIKPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4gd3JvdGU6Cj4+IFdoeSBkb24n
dCB3ZSBqdXN0IGZpeCB1cCB0aGUgY3VycmVudCBHRFMgY29kZSBzbyBpdCB3b3JrcyB0aGUgc2Ft
ZSBhcyB2cmFtCj4+IGFuZCB0aGVuIHdlIGNhbiBhZGQgYSBuZXcgQ1Mgb3IgY29udGV4dCBmbGFn
IHRvIGlnbm9yZSB0aGUgY3VycmVudCBzdGF0aWMKPj4gYWxsb2NhdGlvbiBmb3IgZ2Z4LiAgV2Ug
Y2FuIGlnbm9yZSBkYXRhIHBlcnNpc3RlbmNlIGlmIGl0J3MgdG9vIG11Y2gKPj4gdHJvdWJsZS4g
IEFzc3VtZSB5b3UgYWx3YXlzIGhhdmUgdG8gaW5pdCB0aGUgbWVtb3J5IGJlZm9yZSB5b3UgdXNl
IGl0Lgo+PiBUaGF0J3MgYWxyZWFkeSB0aGUgY2FzZS4KPj4KPj4KPj4gQWxleApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

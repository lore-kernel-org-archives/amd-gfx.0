From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reserve GDS resources statically
Date: Thu, 13 Sep 2018 15:04:35 -0400
Message-ID: <CAAxE2A7Wd9wwQL-43eFi8wjs+oD6-cHWR95nM1U44_yJP6Q4YA@mail.gmail.com>
References: <20180912203358.2172-1-maraeo@gmail.com>
 <904d7dbb-eeec-03a0-92c8-5c5170a7b43c@gmail.com>
 <CAAxE2A44Brp==LORVMuKkU7o+O4wGiBEx7T8yYyMZd_b2uh6Tw@mail.gmail.com>
 <7db280c8-e013-6865-aef7-7c1d5640b875@amd.com>
 <CAAxE2A64kojhUe+drdccAkSE4kTZP94OyMmG+xqH9wdDYgKATg@mail.gmail.com>
 <BN6PR12MB180977B44E93B5357C5145B3F71A0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180977B44E93B5357C5145B3F71A0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

SSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhhdCB0b28sIGJ1dCBpdCB3b3VsZCBiZSB0b28gbXVjaCB0
cm91YmxlIGZvcgpzb21ldGhpbmcgd2UgZG9uJ3QgbmVlZC4KCk1hcmVrCgpPbiBUaHUsIFNlcCAx
MywgMjAxOCBhdCAyOjU3IFBNLCBEZXVjaGVyLCBBbGV4YW5kZXIKPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+IHdyb3RlOgo+IFdoeSBkb24ndCB3ZSBqdXN0IGZpeCB1cCB0aGUgY3VycmVudCBH
RFMgY29kZSBzbyBpdCB3b3JrcyB0aGUgc2FtZSBhcyB2cmFtCj4gYW5kIHRoZW4gd2UgY2FuIGFk
ZCBhIG5ldyBDUyBvciBjb250ZXh0IGZsYWcgdG8gaWdub3JlIHRoZSBjdXJyZW50IHN0YXRpYwo+
IGFsbG9jYXRpb24gZm9yIGdmeC4gIFdlIGNhbiBpZ25vcmUgZGF0YSBwZXJzaXN0ZW5jZSBpZiBp
dCdzIHRvbyBtdWNoCj4gdHJvdWJsZS4gIEFzc3VtZSB5b3UgYWx3YXlzIGhhdmUgdG8gaW5pdCB0
aGUgbWVtb3J5IGJlZm9yZSB5b3UgdXNlIGl0Lgo+IFRoYXQncyBhbHJlYWR5IHRoZSBjYXNlLgo+
Cj4KPiBBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

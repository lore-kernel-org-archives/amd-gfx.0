From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Mon, 24 Jun 2019 11:48:35 +0200
Message-ID: <CAKMK7uHqWY=nWMHi8mOqrjRCwyy_WoHvY4_4w8ESvm8SoKuapg@mail.gmail.com>
References: <9cad6e74-4751-0b0a-35d1-e8f0ac4d3efc@amd.com>
 <20190621090953.GZ12905@phenom.ffwll.local>
 <be9f38f5-6bb5-9535-f3d9-bafa83370e0f@amd.com>
 <CAKMK7uE5qO4q3RYNDp22gkMSSJGgz9ChxhuWPYqXO6D1UUvy6Q@mail.gmail.com>
 <20190621102015.GA21486@arch-x1c3>
 <d241fab3-b6f0-d38a-b83f-03b70736b355@amd.com>
 <CAKMK7uEVziNZJES9=JFBUu=LpmubS8=-A654cMN+QqhEmc8Fvw@mail.gmail.com>
 <c92dc683-6815-dc5a-dc2b-54517cc027de@gmail.com>
 <CAKMK7uHsv3HOXOQq=GGRkx6f+ssRg7dO7qEoBqRS9V_KiTN3Hg@mail.gmail.com>
 <b182c8e3-c060-71f0-2b3b-62600d825c9f@daenzer.net>
 <20190621154416.GE12905@phenom.ffwll.local>
 <13024821-4767-eeaf-86eb-9ae1056f8931@daenzer.net>
 <b03e8977-c51a-9606-383f-cf4ba674dcdd@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b03e8977-c51a-9606-383f-cf4ba674dcdd-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBKdW4gMjQsIDIwMTkgYXQgMTE6MzcgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gT24gMjAxOS0wNi0yMSA1OjUyIHAubS4sIE1pY2hlbCBEw6Ru
emVyIHdyb3RlOgo+ID4+IFRoYXQgd2FzIHRoZSBlbnRpcmUgcG9pbnQgb2Yga21zLCBhbmQgaXQg
c3VjY2VlZCByZWFsbHkgd2VsbC4gVGhhdCdzCj4gPj4gd2h5IEkgZG9uJ3QgdGhpbmsgYW1kZ3B1
IGRvaW5nIHRoZWlyIG93biBmbGF2b3VyIHBpY2sgaXMgZ29pbmcgdG8gaGVscAo+ID4+IGFueW9u
ZSBoZXJlLAo+ID4gT3RoZXIgZHJpdmVycyBhcmUgd2VsY29tZSB0byBlbXVsYXRlIGFtZGdwdSdz
IGRlc2lnbiBtYWtpbmcgdGhlIGFib3ZlCj4gPiBwb3NzaWJsZS4gOikKPgo+IFNlcmlvdXNseSB0
aG91Z2gsIEkgZG9uJ3QgdGhpbmsgYW55IGNoYW5nZXMgb3V0c2lkZSBvZiBsaWJkcm0vTWVzYQo+
IHNob3VsZCBiZSBuZWVkZWQgd2l0aCBvdGhlciBkcml2ZXJzIGVpdGhlci4gRnVuZGFtZW50YWxs
eSB0aGVyZSdzCj4gbm90aGluZyBtYWdpYyBhYm91dCBpdCwganVzdCBzaGFyaW5nIEJPcyB2aWEg
UFJJTUUgYmV0d2VlbiB0aGUgcmVuZGVyCj4gbm9kZSBmaWxlIGRlc2NyaXB0aW9uIGFuZCB0aGF0
IHBhc3NlZCBpbiB2aWEgdGhlIEVHTC9HQk0vLi4uIEFQSS4KClRoZSBsaWJkcm0vbWVzYSBkZXNp
Z24gaXNuJ3QgdGhlIGhhcmQgcGFydCwgd2UgaGF2ZSB0aGF0IGV2ZW4gYXMgYQpoZWxwZXIgZm9y
IGV0bmF2aXYgYW5kIGFsbCB0aG9zZSBkcml2ZXJzLiBCZWluZyBpbmNvbnNpc3RlbnQgaGVyZSBp
cyBhCnRoaW5rIG1vcmUgYSBudWlzYW5jZSBmb3IgaW50ZWdyYXRvcnMsIHdobyBtaWdodCB3YW50
IHRvIHNhbmRib3ggZ3B1CmNsaWVudHMgcmVhbCBoYXJkIGFuZCByZWFsbHkgd2FudCB0byBrbm93
IHdoYXQgYWNjZXNzIHJpZ2h0cyB0aGV5IG5lZWQKdG8gZ2l2ZSBvdXQuCgpCdXQgdGhlbiB3ZSBo
YXZlIG11Y2gsIG11Y2ggYmlnZ2VyIGZpc2ggdG8gZnJ5IGZyb20gYSBjcm9zcy1kcml2ZXIKY29u
c2lzdGVuY3kgcG92LCBzbyAqc2hydWcqLiBKdXN0IGZlZWxzIHNvbWV3aGF0IHNpbGx5IHdlIGNh
bid0IGV2ZW4KZ2V0IGFncmVlbWVudCBvciBzb21lIGtpbmQgb2YgY29uc2lzdGVudCBwbGFuIG9u
IHNvbWV0aGluZyBmYWlybHkKc2ltcGxlIGxpa2UgdGhpcy4KLURhbmllbAotLSAKRGFuaWVsIFZl
dHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KKzQxICgwKSA3OSAzNjUg
NTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=

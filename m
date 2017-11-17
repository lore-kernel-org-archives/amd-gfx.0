From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm: amd: Fix line continuation formats
Date: Fri, 17 Nov 2017 14:52:45 -0500
Message-ID: <CADnq5_MHhjMmeuazwmZg9VUtG=PNTG85GRmfS-m9_t9kdam+wQ@mail.gmail.com>
References: <cover.1510845910.git.joe@perches.com>
 <eee8836696843f983a9533d6441fa9f2d8cbe92f.1510845910.git.joe@perches.com>
 <1b2c63b7-319a-caab-6809-197784c179ef@amd.com>
 <1510847412.31559.25.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510847412.31559.25.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
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
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBOb3YgMTYsIDIwMTcgYXQgMTA6NTAgQU0sIEpvZSBQZXJjaGVzIDxqb2VAcGVyY2hl
cy5jb20+IHdyb3RlOgo+IE9uIFRodSwgMjAxNy0xMS0xNiBhdCAxMDozOCAtMDUwMCwgSGFycnkg
V2VudGxhbmQgd3JvdGU6Cj4+IE9uIDIwMTctMTEtMTYgMTA6MjcgQU0sIEpvZSBQZXJjaGVzIHdy
b3RlOgo+PiA+IExpbmUgY29udGludWF0aW9ucyB3aXRoIGV4Y2VzcyBzcGFjaW5nIGNhdXNlcyB1
bmV4cGVjdGVkIG91dHB1dC4KPiBbXQo+PiA+IEBAIC04NzIsOSArODcwLDggQEAgc3RhdGljIGJv
b2wgcGVyZm9ybV9jbG9ja19yZWNvdmVyeV9zZXF1ZW5jZSgKPj4gPiAgICAgaWYgKHJldHJ5X2Nv
dW50ID49IExJTktfVFJBSU5JTkdfTUFYX0NSX1JFVFJZKSB7Cj4+ID4gICAgICAgICAgICAgQVNT
RVJUKDApOwo+PiA+ICAgICAgICAgICAgIGRtX2xvZ2dlcl93cml0ZShsaW5rLT5jdHgtPmxvZ2dl
ciwgTE9HX0VSUk9SLAo+PiA+IC0gICAgICAgICAgICAgICAgICAgIiVzOiBMaW5rIFRyYWluaW5n
IEVycm9yLCBjb3VsZCBub3QgXAo+PiA+IC0gICAgICAgICAgICAgICAgICAgIGdldCBDUiBhZnRl
ciAlZCB0cmllcy4gXAo+PiA+IC0gICAgICAgICAgICAgICAgICAgUG9zc2libHkgdm9sdGFnZSBz
d2luZyBpc3N1ZSIsIF9fZnVuY19fLAo+PiA+ICsgICAgICAgICAgICAgICAgICAgIiVzOiBMaW5r
IFRyYWluaW5nIEVycm9yLCBjb3VsZCBub3QgZ2V0IENSIGFmdGVyICVkIHRyaWVzLiBQb3NzaWJs
eSB2b2x0YWdlIHN3aW5nIGlzc3VlIiwKPj4KPj4gV291bGQgcHJvYmFibHkgYmUgZ29vZCB0byBh
ZGQgYSAnXG4nIGhlcmUgYXMgd2VsbCBidXQgdGhhdCdzIG5vdCB0aGUgbWFpbiBpbnRlbnRpb24g
b2YgdGhpcyBwYXRjaC4KPgo+IEFib3V0IDEvNCBvZiB0aGUgZG1fbG9nZ2VyX3dyaXRlIGNhbGxz
IGFyZSBtaXNzaW5nCj4gbmV3bGluZXMgYW5kIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGEgc2VwYXJh
dGUgcGF0Y2guCj4KPiBJIGVuY291cmFnZSB5b3UgdG8gZml4IHRoZW0gb25lIGRheS4KPgo+PiBS
ZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4KPiBj
aGVlcnMsIEpvZQoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==

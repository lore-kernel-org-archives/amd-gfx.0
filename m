From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [Nouveau] [PATCH v2 00/14] improve the fb_setcmap helper
Date: Tue, 27 Jun 2017 09:19:48 +0200
Message-ID: <20170627071948.a2v6ibxvfuvk2gxs@phenom.ffwll.local>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
 <20170626093526.7dezn6d74m5ktsok@phenom.ffwll.local>
 <59515CCF.8060406@axentia.se>
 <CAPM=9tzr_B9cWG4gEU_+PgkmVnpKtfBFGfQ85gwWpFs+3WQMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tzr_B9cWG4gEU_+PgkmVnpKtfBFGfQ85gwWpFs+3WQMjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, nouveau <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Philippe Cornu <philippe.cornu-qxv4g6HH51o@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Yannick Fertre <yannick.fertre-qxv4g6HH51o@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "open list:VIRTIO CORE, NET..." <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vincent Abriou <vincent.abriou-qxv4g6HH51o@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gVHVlLCBKdW4gMjcsIDIwMTcgYXQgMDU6NTA6MzhBTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gPgo+ID4gSSdtIHRyYXZlbGluZyBhbmQgY2Fubm90IG1ha2UgcHJvZ3Jlc3MgdGhpcyB3
ZWVrLiBUaGUgbWVyZ2Ugd2luZG93IGlzCj4gPiBhbHNvIHJlYWwgY2xvc2Ugc28gdGhpcyBzZXJp
ZXMgd2lsbCB0aGVyZWZvcmUgcHJvYmFibHkgbWlzcyBpdCB1bmxlc3MKPiA+IHNvbWV0aGluZyB1
bmV4cGVjdGVkIGhhcHBlbnMuLi4KPiAKPiBEb24ndCB3b3JyeSB5b3UgbWlzc2VkIHRoZSBtZXJn
ZSB3aW5kb3cgZm9yIGRybSBhbHJlYWR5LCB3ZSBkb24ndCBtZXJnZQo+IHRoaW5ncyBhZnRlciAt
cmM2LiBQbGVhc2UgcmVtZW1iZXIgdGhlIExpbnVzIG1lcmdlIHdpbmRvdyBpcyBmb3IgbWFpbnRh
aW5lcnMKPiB0byBtZXJnZSBzdHVmZiB0byBMaW51cywgdGhpbmdzIG5lZWQgdG8gYmUgcmVhZHkg
bG9uZyBiZWZvcmUgaXQsIGFuZCBmb3IgZHJtCj4geW91IHNob3VsZG4ndCByZWFsbHkgdGllIHlv
dXJzZWxmIHRvIHRoZSBtZXJnZSBjeWNsZS4KClllYWgsIGRybS1taXNjIGlzIG9wZW4gZm9yIHJl
ZmFjdG9yaW5ncyBsaWtlIHRoaXMgYWxsIHRoZSB0aW1lLCBhbmQKbWFpbnRhaW5lcnMgbWFrZSBz
dXJlIHRoZSBjb2RlIHdpbGwgZ2V0IGludG8gdXBzdHJlYW0gYXNhcCwgd2l0aG91dAppbnRlcmZl
cnJpbmcgd2l0aCB0aGUgdXBzdHJlYW0gbWVyZ2Ugd2luZG93IHNjaGVkdWxlcy4gTGlrZSBEYXZl
IHNhaWQsCmRvbid0IHdvcnJ5LgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVu
Z2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

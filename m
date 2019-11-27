From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
Date: Wed, 27 Nov 2019 19:04:56 +0100
Message-ID: <20191127180456.GD406127@phenom.ffwll.local>
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
 <20191101130313.8862-5-emil.l.velikov@gmail.com>
 <20191127084104.1ceb1f62@collabora.com>
 <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDQ6Mjc6MjlQTSArMDAwMCwgRW1pbCBWZWxpa292IHdy
b3RlOgo+IE9uIFdlZCwgMjcgTm92IDIwMTkgYXQgMDc6NDEsIEJvcmlzIEJyZXppbGxvbgo+IDxi
b3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgRW1pbCwKPiA+
Cj4gPiBPbiBGcmksICAxIE5vdiAyMDE5IDEzOjAzOjEzICswMDAwCj4gPiBFbWlsIFZlbGlrb3Yg
PGVtaWwubC52ZWxpa292QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gPiBGcm9tOiBFbWlsIFZl
bGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+ID4gPgo+ID4gPiBBcyBtZW50aW9u
ZWQgYnkgQ2hyaXN0aWFuLCBmb3IgZHJpdmVycyB3aGljaCBzdXBwb3J0IG9ubHkgcHJpbWFyeSBu
b2Rlcwo+ID4gPiB0aGlzIGNoYW5nZXMgdGhlIHJldHVybmVkIGVycm9yIGZyb20gLUVBQ0NFUyBp
bnRvIC1FT1BOT1RTVVBQLy1FTk9TWVMuCj4gPgo+ID4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgdHJ1
ZSBmb3IgTU9ERVNFVC1vbmx5IG5vZGVzICh0aG9zZSB0aGF0IGRvIG5vdAo+ID4gaGF2ZSB0aGUg
UkVOREVSIGNhcCBzZXQpIGltcGxlbWVudGluZyAtPntmZF90b19oYW5kbGUsaGFuZGxlX3RvX2Zk
fSgpPwo+ID4gU2hvdWxkbid0IHRoZSBpc19hdXRoZW50aWNhdGVkKCkgY2hlY2sgc3RpbGwgYmUg
ZG9uZSBpbiB0aGF0IGNhc2U/Cj4gPgo+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4gSnVzdCBz
ZW50IG91dCB2Miwgd2hpY2ggSSBzaG91bGQgYWRkcmVzcyB0aGUgY29uY2Vybi4KCldoeSBkbyB3
ZSBuZWVkIHRoaXMgYWRkaXRpb25hbCBjaGVjayBpbiB2Mj8gV2hhdCBjYW4gZ28gd3Jvbmcgb24g
bW9kZXNldApkcml2ZXJzIGlmIG5vbi1hdXRoZW50aWNhdGVkIGxlZ2FjeSB0aGluZ3MgY2FuIHVz
ZSB0aGlzPyBtb2Rlc2V0LW9ubHkKZHJpdmVycyBoYXZlIGFsbCB0aGVpciByZXNvdXJjZXMgc2Vn
cmVnYXRlZCBieSB0aGUgZHJtIGNvcmUgKGRybV9mYiwKbW1hcHMsIGJ1ZmZlciBsaXN0cyksIHNv
IHRoZXJlJ3MgcmVhbGx5IG5vIGFjY2VzcyBsaW1pdGF0aW9ucyB0aGF0IGNhbiBnbwp3cm9uZyBo
ZXJlLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBD
b3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=

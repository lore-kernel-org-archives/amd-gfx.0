From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/radeon: Fill out gem_object->resv
Date: Tue, 25 Jun 2019 22:52:17 +0200
Message-ID: <20190625205217.GC19279@ravnborg.org>
References: <20190625204208.5614-1-daniel.vetter@ffwll.ch>
 <20190625204208.5614-5-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190625204208.5614-5-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
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
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Emil Velikov <emil.velikov-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NDI6MDVQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBUaGF0IHdheSB3ZSBjYW4gZGl0Y2ggb3VyIGdlbV9wcmltZV9yZXNfb2JqIGltcGxl
bWVudGF0aW9uLiBTaW5jZSB0dG0KPiBhYnNvbHV0ZWx5IG5lZWRzIHRoZSByaWdodCByZXNlcnZh
dGlvbiBvYmplY3QgYWxsIHRoZSBib2lsZXJwbGF0ZSBpcwo+IGFscmVhZHkgdGhlcmUgYW5kIHdl
IGp1c3QgaGF2ZSB0byB3aXJlIGl0IHVwIGNvcnJlY3RseS4KPiAKPiBOb3RlIHRoYXQgZ2VtL3By
aW1lIGRvZXNuJ3QgY2FyZSB3aGVuIHdlIGRvIHRoaXMsIGFzIGxvbmcgYXMgd2UgZG8gaXQKPiBi
ZWZvcmUgdGhlIGJvIGlzIHJlZ2lzdGVyZWQgYW5kIHNvbWVvbmUgY2FuIGNhbGwgdGhlIGhhbmRs
ZTJmZCBpb2N0bAo+IG9uIGl0Lgo+IAo+IEFzaWRlOiB0dG1fYnVmZmVyX29iamVjdC50dG1fcmVz
diBjb3VsZCBwcm9iYWJseSBiZSBkaXRjaGVkIGluIGZhdm91cgo+IG9mIGFsd2F5cyBwYXNzaW5n
IGEgbm9uLU5VTEwgcmVzdiB0byB0dG1fYm9faW5pdCgpLiBBdCBsZWFzdCBmb3IgZ2VtCj4gZHJp
dmVycyB0aGF0IHdvdWxkIGF2b2lkIGhhdmluZyB0d28gb2YgdGhlc2UsIG9uIGluIHR0bV9idWZm
ZXJfb2JqZWN0Cj4gYW5kIHRoZSBvdGhlciBpbiBkcm1fZ2VtX29iamVjdCwgb25lIGp1c3QgdGhl
cmUgZm9yIGNvbmZ1c2lvbi4KU29tZXRoaW5nIGZvciB0b2RvLnJzdCAtIHNvIHRoaXMgZG9lcyBu
b3QgZ2V0IGxvc3QgaW4gYSBjaGFuZ2Vsb2cKcGVvcGxlIHdpbGwgc29vbiBmb3JnZXQ/CgoJU2Ft
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

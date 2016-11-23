From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx7: move eop programming per queue
Date: Wed, 23 Nov 2016 18:50:28 -0500
Message-ID: <CADnq5_Pxi=xkyVS0jUDMw9Ax5vmfJcS59N-SrfvY_JnnUUpcmg@mail.gmail.com>
References: <1479932826-3362-1-git-send-email-alexander.deucher@amd.com>
 <1479932826-3362-2-git-send-email-alexander.deucher@amd.com>
 <1479942059.4125077.797525393.1034ADD9@webmail.messagingengine.com>
 <CADnq5_OVmdTJQpGqOdxvDVhSvGeX5eAgOmJdtA-K2jEDMWaYJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OVmdTJQpGqOdxvDVhSvGeX5eAgOmJdtA-K2jEDMWaYJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBOb3YgMjMsIDIwMTYgYXQgNjo0OSBQTSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTm92IDIzLCAyMDE2IGF0IDY6MDAgUE0sIEph
eSBDb3Jud2FsbCA8amF5QGpjb3Jud2FsbC5tZT4gd3JvdGU6Cj4+IE9uIFdlZCwgTm92IDIzLCAy
MDE2LCBhdCAxNDoyNywgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gSXQncyBwZXIgcXVldWUgbm90
IHBlciBwaXBlLgo+Pgo+PiBBcmUgeW91IHN1cmU/IEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9u
IHRoYXQgRU9QIHF1ZWV1cyB3ZXJlIHBlci1waXBlCj4+IG9uIEdmeDcgYW5kIHBlci1xdWV1ZSBv
biBHZng4IG9ud2FyZHMgKHRvIHN1cHBvcnQgY29udGV4dCBzYXZlL3Jlc3RvcmUpLgo+PiBJdCdz
IGFsc28gaGludGVkIGF0IGJ5IHRoZSByZWdpc3RlciBuYW1lIChIUEQgPT0gSGFyZHdhcmUgUGlw
ZQo+PiBEZXNjcmlwdG9yLCBIUUQgPT0gSGFyZHdhcmUgUXVldWUgRGVzY3JpcHRvcikuCj4KPiBO
bywgSSdtIG5vdCBzdXJlLiAgSSBoYXZlIGEgcGF0Y2ggc2V0IGZvciBhbWRncHUgdG8gbGVhdmUg
dGhlCj4gZmJfbG9jYXRpb24gYXMgcHJvZ3JhbW1lZCBieSB0aGUgdmJpb3MgcmF0aGVyIHRoYW4g
cmVwcm9ncmFtbWluZyB3aGljaAo+IHJlc3VsdGVkIGluIHZyYW0gbm90IGJlaW5nIGF0IDAgaW4g
dGhlIEdQVSdzIGFkZHJlc3Mgc3BhY2UuICBJIHRoZW4KPiBnb3QgcmluZyBmYWlsdXJlcyBvbiB0
aGUgY29tcHV0ZSBxdWV1ZXMgdW50aWwgSSBtYWRlIHRoZSBlb3BzIHBlcgo+IHF1ZXVlLiAgSXQg
Y291bGQgYmUgc29tZXRoaW5nIGVsc2UsIGJ1dCB0aGlzIHNlZW1lZCB0byBmaXggaXQuCgpBY3R1
YWxseSBJJ3ZlIG9ubHkgdHJpZWQgdGhpcyBvbiBnZng4LCBJIGp1c3QgYXNzdW1lZCBnZng3IHdh
cyBhbHNvCmFmZmVjdGVkLCBidXQgaXQncyBwb3NzaWJsZSB0aGlzIGlzIG5vdCBuZWVkZWQgZm9y
IGdmeCA3LgoKQWxleApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

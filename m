From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.
Date: Wed, 1 Feb 2017 15:36:47 +0000
Message-ID: <5892008F.8030008@gmail.com>
References: <1483944700-3842-1-git-send-email-Rex.Zhu@amd.com>
 <1483944700-3842-4-git-send-email-Rex.Zhu@amd.com>
 <5876B5C8.1010401@gmail.com> <58911B91.50008@gmail.com>
 <CADnq5_N27CHyxLZQMypKUsBGO3tfGcbW3+aO-vQM+=7NShghCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N27CHyxLZQMypKUsBGO3tfGcbW3+aO-vQM+=7NShghCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFR1ZSwgSmFuIDMxLCAyMDE3IGF0IDY6MTkgUE0sIEFu
ZHkgRnVybmlzcyA8YWRmLmxpc3RzQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEFuZHkgRnVybmlzcyB3
cm90ZToKPj4+Cj4+PiBSZXggWmh1IHdyb3RlOgo+Pj4+Cj4+Pj4gaW4gcHJvZmlsaW5nIG1vZGUs
IHBvd2VycGxheSB3aWxsIGZpeCBwb3dlciBzdGF0ZQo+Pj4+IGFzIHN0YWJsZSBhcyBwb3NzaWJs
ZS5hbmQgZGlzYWJsZSBnZnggY2cgYW5kIExCUFcgZmVhdHVyZS4KPj4+Pgo+Pj4+IHByb2ZpbGVf
c3RhbmRhcmQ6IGFzIGEgcHJlcmVxdWlzaXRlLCBlbnN1cmUgcG93ZXIgYW5kIHRoZXJtYWwKPj4+
PiBzdXN0YWluYWJsZSwgc2V0IGNsb2NrcyByYXRpbyBhcyBjbG9zZSB0byB0aGUgaGlnaGVzdCBj
bG9jawo+Pj4+IHJhdGlvIGFzIHBvc3NpYmxlLgo+Pj4+IHByb2ZpbGVfbWluX3NjbGs6IGZpeCBt
Y2xrIGFzIHByb2ZpbGVfbm9ybWFsLCBzZXQgbG93ZXN0IHNjbGsKPj4+PiBwcm9maWxlX21pbl9t
Y2xrOiBmaXggc2NsayBhcyBwcm9maWxlX25vcm1hbCwgc2V0IGxvd2VzdCBtY2xrCj4+Pj4gcHJv
ZmlsZV9wZWFrOiBzZXQgaGlnaGVzdCBzY2xrIGFuZCBtY2xrLCBwb3dlciBhbmQgdGhlcm1hbCBu
b3QKPj4+PiBzdXN0YWluYWJsZQo+Pj4+IHByb2ZpbGVfZXhpdDogZXhpdCBwcm9maWxlIG1vZGUu
IGVuYWJsZSBnZnggY2cvbGJwdyBmZWF0dXJlLgo+Pj4KPj4+Cj4+PiBUZXN0aW5nIFI5IDI4NSBU
b25nYSBvbiBkcm0tbmV4dC00LjExLXdpcAo+Pj4KPj4+IFRoaXMgY29tbWl0IGhhcyB0aGUgZWZm
ZWN0IHRoYXQgZG9pbmcKPj4+Cj4+PiBlY2hvIGhpZ2ggPiAvc3lzL2NsYXNzL2RybS9jYXJkMC9k
ZXZpY2UvcG93ZXJfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVsCj4+Pgo+Pj4gaW5zdGFudGx5
IGZvcmNlcyBmYW4gdG8gKEkgZ3Vlc3MpIG1heCwgd2hlcmUgbm9ybWFsbHkgaXQgZG9lc24ndAo+
Pj4gbmVlZCBhbnl0aGluZyBsaWtlIGFzIGZhc3Qgd2l0aCB0aGUgY2xvY2tzIGhpZ2ggd2hlbiBk
b2luZyBub3RoaW5nIGVsc2UuCj4+Cj4+Cj4+IFBpbmcgLSBqdXN0IGluIGNhc2UgdGhpcyBnb3Qg
bWlzc2VkLCBzdGlsbCB0aGUgc2FtZSBvbiBjdXJyZW50Cj4+IGRybS1uZXh0LTQuMTEtd2lwCj4K
PiBKdXN0IGEgaGVhZHMgdXAsIFJleCB3YXMgbG9va2luZyBhdCB0aGlzLCBidXQgaXQncyBDaGlu
ZXNlIE5ldyBZZWFyIHRoaXMgd2Vlay4KCk9LLCB0aGFua3MgJiBIYXBweSBuZXcgeWVhci4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

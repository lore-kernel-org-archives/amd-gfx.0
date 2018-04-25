From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH 4/8] dma-buf: add peer2peer flag
Date: Wed, 25 Apr 2018 09:02:17 +0200
Message-ID: <CAKMK7uGF7p5ko=i6zL4dn0qR-5TVRKMi6xaCGSao_vyfJU+dWQ@mail.gmail.com>
References: <3e17afc5-7d6c-5795-07bd-f23e34cf8d4b@gmail.com>
 <20180420101755.GA11400@infradead.org>
 <f1100bd6-dd98-55a9-a92f-1cad919f235f@amd.com>
 <20180420124625.GA31078@infradead.org>
 <20180420152111.GR31310@phenom.ffwll.local>
 <20180424184847.GA3247@infradead.org>
 <CAKMK7uFL68pu+-9LODTgz+GQYvxpnXOGhxfz9zorJ_JKsPVw2g@mail.gmail.com>
 <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425064335.GB28100-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gV2VkLCBBcHIgMjUsIDIwMTggYXQgODo0MyBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyNSwgMjAxOCBhdCAwODoyMzoxNUFN
ICswMjAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+PiBGb3IgbW9yZSBmdW46Cj4+Cj4+IGh0dHBz
Oi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2RyaS1kZXZlbC9tc2cxNzM2MzAuaHRtbAo+Pgo+PiBZ
ZWFoLCBzb21ldGltZXMgd2Ugd2FudCB0byBkaXNhYmxlIHRoZSBpb21tdSBiZWNhdXNlIHRoZSBv
bi1ncHUKPj4gcGFnZXRhYmxlcyBhcmUgZmFzdGVyIC4uLgo+Cj4gSSBhbSBub3Qgb24gdGhpcyBs
aXN0LCBidXQgcmVtb3RlIE5BSyBmcm9tIGhlcmUuICBUaGlzIG5lZWRzIGFuCj4gQVBJIGZyb20g
dGhlIGlvbW11L2RtYS1tYXBwaW5nIGNvZGUuICBEcml2ZXJzIGhhdmUgbm8gYnVzaW5lc3MgcG9r
aW5nCj4gaW50byB0aGVzZSBkZXRhaWxzLgoKQ2FuIHdlIHBsZWFzZSBub3QgbmFjayBldmVyeXRo
aW5nIHJpZ2h0IGF3YXk/IERvZXNuJ3QgcmVhbGx5IG1vdGl2YXRlCm1lIHRvIHNob3cgeW91IGFs
bCB0aGUgdmFyaW91cyB0aGluZ3Mgd2UncmUgZG9pbmcgaW4gZ3B1IHRvIG1ha2UgdGhlCmRtYSBs
YXllciB3b3JrIGZvciB1cy4gVGhhdCBraW5kIG9mIG5vb2RsaW5nIGFyb3VuZCBpbiBsb3dlciBs
ZXZlbHMgdG8KZ2V0IHRoZW0gdG8gZG8gd2hhdCB3ZSB3YW50IGlzIGFic29sdXRlbHkgcGFyLWZv
ci1jb3Vyc2UgZm9yIGdwdQpkcml2ZXJzLiBJZiB5b3UganVzdCBuYWNrIGV2ZXJ5dGhpbmcgSSBw
b2ludCB5b3UgYXQgZm9yIGlsbHVzdHJhdGl2ZQpwdXJwb3NlcywgdGhlbiBJIGNhbid0IHNob3cg
eW91IHN0dWZmIGFueW1vcmUuCgpKdXN0IHRvIG1ha2UgaXQgY2xlYXI6IEkgZG8gd2FudCB0byBn
ZXQgdGhpcyBzdHVmZiBzb3J0ZWQsIGFuZCBpdCdzCmF3ZXNvbWUgdGhhdCBzb21lb25lIGZyb20g
Y29yZSBmaW5hbGx5IHRha2VzIGEgc2VyaW91cyBsb29rIGF0IHdoYXQKZ3B1IGZvbGtzIGhhdmUg
YmVlbiBkb2luZyBmb3IgZGVjYWRlcyAoaW5zdGVhZCBvZiBqdXN0IHRlbGxpbmcgdXMKd2UncmUg
aW5jb21wZXRlbnQgYW5kIGRvaW5nIGl0IGFsbCB3cm9uZyBhbmQgdGhlbiBzdGVhbWluZyBvZmYp
LCBhbmQKaG93IHRvIG1ha2UgdGhpcyB3b3JrIHdpdGhvdXQgbGF5ZXJpbmcgdmlvbGF0aW9ucyB0
byBubyBlbmQuIEJ1dApzdG9wcGluZyB0aGUgd29ybGQgdW50aWwgdGhpcyBpcyBmaXhlZCBpc24n
dCByZWFsbHkgYSBnb29kIG9wdGlvbi4KClRoYW5rcywgRGFuaWVsCgo+IFRoaWVycnksIHBsZWFz
ZSByZXNlbmQgdGhpcyB3aXRoIGF0IGxlYXN0IHRoZSBpb21tdSBsaXN0IGFuZAo+IGxpbnV4LWFy
bS1rZXJuZWwgaW4gQ2MgdG8gaGF2ZSBhIHByb3BlciBkaXNjdXNzaW9uIG9uIHRoZSByaWdodCBB
UEkuCgoKCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3Jh
dGlvbgorNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

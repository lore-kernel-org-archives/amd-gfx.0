From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH 4/8] dma-buf: add peer2peer flag
Date: Wed, 25 Apr 2018 13:44:33 -0400
Message-ID: <CADnq5_O5t8aSJE6SFzyjw-6Pmba7B2aYMztVMOOQCF3drBHR5Q@mail.gmail.com>
References: <3e17afc5-7d6c-5795-07bd-f23e34cf8d4b@gmail.com>
 <20180420101755.GA11400@infradead.org>
 <f1100bd6-dd98-55a9-a92f-1cad919f235f@amd.com>
 <20180420124625.GA31078@infradead.org>
 <20180420152111.GR31310@phenom.ffwll.local>
 <20180424184847.GA3247@infradead.org>
 <CAKMK7uFL68pu+-9LODTgz+GQYvxpnXOGhxfz9zorJ_JKsPVw2g@mail.gmail.com>
 <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CADnq5_P3bT0TStSXpKh11ydifv=KwKtRj-7tDS=GQXey+8tBPw@mail.gmail.com>
 <20180425064118.GA28100@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425064118.GA28100-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gV2VkLCBBcHIgMjUsIDIwMTggYXQgMjo0MSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyNSwgMjAxOCBhdCAwMjoyNDozNkFN
IC0wNDAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+ID4gSXQgaGFzIGEgbm9uLWNvaGVyZW50IHRy
YW5zYWN0aW9uIG1vZGUgKHdoaWNoIHRoZSBjaGlwc2V0IGNhbiBvcHQgdG8KPj4gPiBub3QgaW1w
bGVtZW50IGFuZCBzdGlsbCBmbHVzaCksIHRvIG1ha2Ugc3VyZSB0aGUgQUdQIGhvcnJvciBzaG93
Cj4+ID4gZG9lc24ndCBoYXBwZW4gYWdhaW4gYW5kIEdQVSBmb2xrcyBhcmUgaGFwcHkgd2l0aCBQ
Q0llLiBUaGF0J3MgYXQKPj4gPiBsZWFzdCBteSB1bmRlcnN0YW5kaW5nIGZyb20gZGlnZ2luZyBh
cm91bmQgaW4gYW1kIHRoZSBsYXN0IHRpbWUgd2UgaGFkCj4+ID4gY29oZXJlbmN5IGlzc3VlcyBi
ZXR3ZWVuIGludGVsIGFuZCBhbWQgZ3B1cy4gR1BVcyBoYXZlIHNvbWUgYml0cwo+PiA+IHNvbWV3
aGVyZSAoaW4gdGhlIHBhZ2V0YWJsZXMsIG9yIGluIHRoZSBidWZmZXIgb2JqZWN0IGRlc2NyaXB0
aW9uCj4+ID4gdGFibGUgY3JlYXRlZCBieSB1c2Vyc3BhY2UpIHRvIGNvbnRyb2wgdGhhdCBzdHVm
Zi4KPj4KPj4gUmlnaHQuICBXZSBoYXZlIGEgYml0IGluIHRoZSBHUFUgcGFnZSB0YWJsZSBlbnRy
aWVzIHRoYXQgZGV0ZXJtaW5lcwo+PiB3aGV0aGVyIHdlIHNub29wIHRoZSBDUFUncyBjYWNoZSBv
ciBub3QuCj4KPiBJIGNhbiBzZWUgaG93IHRoYXQgd29ya3Mgd2l0aCB0aGUgR1BVIG9uIHRoZSBz
YW1lIFNPQyBvciBTT0Mgc2V0IGFzIHRoZQo+IENQVS4gIEJ1dCBob3cgaXMgdGhhdCBnb2luZyB0
byB3b3JrIGZvciBhIEdQVSB0aGF0IGlzIGEgcGxhaW4gb2xkIFBDSWUKPiBjYXJkPyAgVGhlIGNh
Y2hlIHNub29waW5nIGluIHRoYXQgY2FzZSBpcyBoYXBwZW5pbmcgaW4gdGhlIFBDSWUgcm9vdAo+
IGNvbXBsZXguCgpJJ20gbm90IGEgcGNpIGV4cGVydCwgYnV0IGFzIGZhciBhcyBJIGtub3csIHRo
ZSBkZXZpY2Ugc2VuZHMgZWl0aGVyIGEKc25vb3BlZCBvciBub24tc25vb3BlZCB0cmFuc2FjdGlv
biBvbiB0aGUgYnVzLiAgSSB0aGluayB0aGUKdHJhbnNhY3Rpb24gZGVzY3JpcHRvciBzdXBwb3J0
cyBhIG5vIHNub29wIGF0dHJpYnV0ZS4gIE91ciBHUFVzIGhhdmUKc3VwcG9ydGVkIHRoaXMgZmVh
dHVyZSBmb3IgcHJvYmFibHkgMjAgeWVhcnMgaWYgbm90IG1vcmUsIGdvaW5nIGJhY2sKdG8gUENJ
LiAgVXNpbmcgbm9uLXNub29wZWQgdHJhbnNhY3Rpb25zIGhhdmUgbG93ZXIgbGF0ZW5jeSBhbmQg
ZmFzdGVyCnRocm91Z2hwdXQgY29tcGFyZWQgdG8gc25vb3BlZCB0cmFuc2FjdGlvbnMuCgpBbGV4
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

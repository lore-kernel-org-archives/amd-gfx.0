From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 4/8] dma-buf: add peer2peer flag
Date: Wed, 25 Apr 2018 11:38:03 -0700
Message-ID: <CAPcyv4gvz8hWLiz3wSitoh3546WV7d=LRYzu5nd9MpKKH7C=mg@mail.gmail.com>
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
 <CADnq5_O5t8aSJE6SFzyjw-6Pmba7B2aYMztVMOOQCF3drBHR5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_O5t8aSJE6SFzyjw-6Pmba7B2aYMztVMOOQCF3drBHR5Q@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Jerome Glisse <jglisse@redhat.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Logan Gunthorpe <logang@deltatee.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBcHIgMjUsIDIwMTggYXQgMTA6NDQgQU0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyNSwgMjAxOCBhdCAyOjQxIEFNLCBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+PiBPbiBXZWQsIEFw
ciAyNSwgMjAxOCBhdCAwMjoyNDozNkFNIC0wNDAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+PiA+
IEl0IGhhcyBhIG5vbi1jb2hlcmVudCB0cmFuc2FjdGlvbiBtb2RlICh3aGljaCB0aGUgY2hpcHNl
dCBjYW4gb3B0IHRvCj4+PiA+IG5vdCBpbXBsZW1lbnQgYW5kIHN0aWxsIGZsdXNoKSwgdG8gbWFr
ZSBzdXJlIHRoZSBBR1AgaG9ycm9yIHNob3cKPj4+ID4gZG9lc24ndCBoYXBwZW4gYWdhaW4gYW5k
IEdQVSBmb2xrcyBhcmUgaGFwcHkgd2l0aCBQQ0llLiBUaGF0J3MgYXQKPj4+ID4gbGVhc3QgbXkg
dW5kZXJzdGFuZGluZyBmcm9tIGRpZ2dpbmcgYXJvdW5kIGluIGFtZCB0aGUgbGFzdCB0aW1lIHdl
IGhhZAo+Pj4gPiBjb2hlcmVuY3kgaXNzdWVzIGJldHdlZW4gaW50ZWwgYW5kIGFtZCBncHVzLiBH
UFVzIGhhdmUgc29tZSBiaXRzCj4+PiA+IHNvbWV3aGVyZSAoaW4gdGhlIHBhZ2V0YWJsZXMsIG9y
IGluIHRoZSBidWZmZXIgb2JqZWN0IGRlc2NyaXB0aW9uCj4+PiA+IHRhYmxlIGNyZWF0ZWQgYnkg
dXNlcnNwYWNlKSB0byBjb250cm9sIHRoYXQgc3R1ZmYuCj4+Pgo+Pj4gUmlnaHQuICBXZSBoYXZl
IGEgYml0IGluIHRoZSBHUFUgcGFnZSB0YWJsZSBlbnRyaWVzIHRoYXQgZGV0ZXJtaW5lcwo+Pj4g
d2hldGhlciB3ZSBzbm9vcCB0aGUgQ1BVJ3MgY2FjaGUgb3Igbm90Lgo+Pgo+PiBJIGNhbiBzZWUg
aG93IHRoYXQgd29ya3Mgd2l0aCB0aGUgR1BVIG9uIHRoZSBzYW1lIFNPQyBvciBTT0Mgc2V0IGFz
IHRoZQo+PiBDUFUuICBCdXQgaG93IGlzIHRoYXQgZ29pbmcgdG8gd29yayBmb3IgYSBHUFUgdGhh
dCBpcyBhIHBsYWluIG9sZCBQQ0llCj4+IGNhcmQ/ICBUaGUgY2FjaGUgc25vb3BpbmcgaW4gdGhh
dCBjYXNlIGlzIGhhcHBlbmluZyBpbiB0aGUgUENJZSByb290Cj4+IGNvbXBsZXguCj4KPiBJJ20g
bm90IGEgcGNpIGV4cGVydCwgYnV0IGFzIGZhciBhcyBJIGtub3csIHRoZSBkZXZpY2Ugc2VuZHMg
ZWl0aGVyIGEKPiBzbm9vcGVkIG9yIG5vbi1zbm9vcGVkIHRyYW5zYWN0aW9uIG9uIHRoZSBidXMu
ICBJIHRoaW5rIHRoZQo+IHRyYW5zYWN0aW9uIGRlc2NyaXB0b3Igc3VwcG9ydHMgYSBubyBzbm9v
cCBhdHRyaWJ1dGUuICBPdXIgR1BVcyBoYXZlCj4gc3VwcG9ydGVkIHRoaXMgZmVhdHVyZSBmb3Ig
cHJvYmFibHkgMjAgeWVhcnMgaWYgbm90IG1vcmUsIGdvaW5nIGJhY2sKPiB0byBQQ0kuICBVc2lu
ZyBub24tc25vb3BlZCB0cmFuc2FjdGlvbnMgaGF2ZSBsb3dlciBsYXRlbmN5IGFuZCBmYXN0ZXIK
PiB0aHJvdWdocHV0IGNvbXBhcmVkIHRvIHNub29wZWQgdHJhbnNhY3Rpb25zLgoKUmlnaHQsICdu
byBzbm9vcCcgYW5kICdyZWxheGVkIG9yZGVyaW5nJyBoYXZlIGJlZW4gcGFydCBvZiB0aGUgUENJ
CnNwZWMgc2luY2UgZm9yZXZlci4gV2l0aCBhIHBsYWluIG9sZCBQQ0ktRSBjYXJkIHRoZSByb290
IGNvbXBsZXgKaW5kZWVkIGFycmFuZ2VzIGZvciBjYWNoZXMgdG8gYmUgc25vb3BlZC4gQWx0aG91
Z2ggaXQncyBub3QgYWx3YXlzCmZhc3RlciBkZXBlbmRpbmcgb24gdGhlIHBsYXRmb3JtLiAnTm8g
c25vb3AnIHRyYWZmaWMgbWF5IGJlIHJlbGVnYXRlZAp0byBsZXNzIGJ1cyByZXNvdXJjZXMgcmVs
YXRpdmUgdG8gdGhlIG11Y2ggbW9yZSBjb21tb24gc25vb3BlZAp0cmFmZmljLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

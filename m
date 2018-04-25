From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Linaro-mm-sig] [PATCH 4/8] dma-buf: add peer2peer flag
Date: Tue, 24 Apr 2018 23:41:18 -0700
Message-ID: <20180425064118.GA28100@infradead.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_P3bT0TStSXpKh11ydifv=KwKtRj-7tDS=GQXey+8tBPw@mail.gmail.com>
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
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Jerome Glisse <jglisse@redhat.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBcHIgMjUsIDIwMTggYXQgMDI6MjQ6MzZBTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+ID4gSXQgaGFzIGEgbm9uLWNvaGVyZW50IHRyYW5zYWN0aW9uIG1vZGUgKHdoaWNoIHRo
ZSBjaGlwc2V0IGNhbiBvcHQgdG8KPiA+IG5vdCBpbXBsZW1lbnQgYW5kIHN0aWxsIGZsdXNoKSwg
dG8gbWFrZSBzdXJlIHRoZSBBR1AgaG9ycm9yIHNob3cKPiA+IGRvZXNuJ3QgaGFwcGVuIGFnYWlu
IGFuZCBHUFUgZm9sa3MgYXJlIGhhcHB5IHdpdGggUENJZS4gVGhhdCdzIGF0Cj4gPiBsZWFzdCBt
eSB1bmRlcnN0YW5kaW5nIGZyb20gZGlnZ2luZyBhcm91bmQgaW4gYW1kIHRoZSBsYXN0IHRpbWUg
d2UgaGFkCj4gPiBjb2hlcmVuY3kgaXNzdWVzIGJldHdlZW4gaW50ZWwgYW5kIGFtZCBncHVzLiBH
UFVzIGhhdmUgc29tZSBiaXRzCj4gPiBzb21ld2hlcmUgKGluIHRoZSBwYWdldGFibGVzLCBvciBp
biB0aGUgYnVmZmVyIG9iamVjdCBkZXNjcmlwdGlvbgo+ID4gdGFibGUgY3JlYXRlZCBieSB1c2Vy
c3BhY2UpIHRvIGNvbnRyb2wgdGhhdCBzdHVmZi4KPiAKPiBSaWdodC4gIFdlIGhhdmUgYSBiaXQg
aW4gdGhlIEdQVSBwYWdlIHRhYmxlIGVudHJpZXMgdGhhdCBkZXRlcm1pbmVzCj4gd2hldGhlciB3
ZSBzbm9vcCB0aGUgQ1BVJ3MgY2FjaGUgb3Igbm90LgoKSSBjYW4gc2VlIGhvdyB0aGF0IHdvcmtz
IHdpdGggdGhlIEdQVSBvbiB0aGUgc2FtZSBTT0Mgb3IgU09DIHNldCBhcyB0aGUKQ1BVLiAgQnV0
IGhvdyBpcyB0aGF0IGdvaW5nIHRvIHdvcmsgZm9yIGEgR1BVIHRoYXQgaXMgYSBwbGFpbiBvbGQg
UENJZQpjYXJkPyAgVGhlIGNhY2hlIHNub29waW5nIGluIHRoYXQgY2FzZSBpcyBoYXBwZW5pbmcg
aW4gdGhlIFBDSWUgcm9vdApjb21wbGV4LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK

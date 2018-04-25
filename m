From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Linaro-mm-sig] [PATCH 4/8] dma-buf: add peer2peer flag
Date: Wed, 25 Apr 2018 00:09:05 -0700
Message-ID: <20180425070905.GA24827@infradead.org>
References: <f1100bd6-dd98-55a9-a92f-1cad919f235f@amd.com>
 <20180420124625.GA31078@infradead.org>
 <20180420152111.GR31310@phenom.ffwll.local>
 <20180424184847.GA3247@infradead.org>
 <CAKMK7uFL68pu+-9LODTgz+GQYvxpnXOGhxfz9zorJ_JKsPVw2g@mail.gmail.com>
 <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org>
 <CAKMK7uGF7p5ko=i6zL4dn0qR-5TVRKMi6xaCGSao_vyfJU+dWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uGF7p5ko=i6zL4dn0qR-5TVRKMi6xaCGSao_vyfJU+dWQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Jerome Glisse <jglisse@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Thierry Reding <treding@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBcHIgMjUsIDIwMTggYXQgMDk6MDI6MTdBTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBDYW4gd2UgcGxlYXNlIG5vdCBuYWNrIGV2ZXJ5dGhpbmcgcmlnaHQgYXdheT8gRG9l
c24ndCByZWFsbHkgbW90aXZhdGUKPiBtZSB0byBzaG93IHlvdSBhbGwgdGhlIHZhcmlvdXMgdGhp
bmdzIHdlJ3JlIGRvaW5nIGluIGdwdSB0byBtYWtlIHRoZQo+IGRtYSBsYXllciB3b3JrIGZvciB1
cy4gVGhhdCBraW5kIG9mIG5vb2RsaW5nIGFyb3VuZCBpbiBsb3dlciBsZXZlbHMgdG8KPiBnZXQg
dGhlbSB0byBkbyB3aGF0IHdlIHdhbnQgaXMgYWJzb2x1dGVseSBwYXItZm9yLWNvdXJzZSBmb3Ig
Z3B1Cj4gZHJpdmVycy4gSWYgeW91IGp1c3QgbmFjayBldmVyeXRoaW5nIEkgcG9pbnQgeW91IGF0
IGZvciBpbGx1c3RyYXRpdmUKPiBwdXJwb3NlcywgdGhlbiBJIGNhbid0IHNob3cgeW91IHN0dWZm
IGFueW1vcmUuCgpObywgaXQncyBub3QuICBObyBkcml2ZXIgKGFuZCB0aGF0IGluY2x1ZGVzIHRo
ZSBtYWdpYyBHUFVzKSBoYXMKYW55IGJ1c2luZXNzIG1lc3Npbmcgd2l0aCBkbWEgb3BzIGRpcmVj
dGx5LgoKQSBHUFUgZHJpdmVyIGltZ2h0IGhhdmUgYSB2ZXJ5IHZhbGlkIHJlYXNvbiB0byBkaXNh
YmxlIHRoZSBJT01NVSwKYnV0IHRoZSBjb2RlIHRvIGRvIHNvIG5lZWRzIHRvIGJlIGF0IGxlYXN0
IGluIHRoZSBhcmNoIGNvZGUsIG1heWJlCmluIHRoZSBkbWEtbWFwcGluZy9pb21tdSBjb2RlLCBu
b3QgaW4gdGhlIGRyaXZlci4KCkFzIGEgZmlyc3Qgc3RlcCB0byBnZXQgdGhlIGRpc2N1c3Npb24g
c3RhcnRlZCB3ZSdsbCBzaW1wbHkgbmVlZAp0byBtb3ZlIHRoZSBjb2RlIFRoaWVycnkgd3JvdGUg
aW50byBhIGhlbHBlciBpbiBhcmNoL2FybSBhbmQgdGhhdAphbG9uZSB3b3VsZCBiZSBhIG1hc3Np
dmUgaW1wcm92ZW1lbnQuICBJJ20gbm90IGV2ZW4gdGFsa2luZyBhYm91dAptaW5vciBkZXRhaWxz
IGxpa2UgYWN0dWFsbHkgdXNpbmcgYXJtX2dldF9kbWFfbWFwX29wcyBpbnN0ZWFkCm9mIGR1cGxp
Y2F0aW5nIGl0LgoKQW5kIGRvaW5nIHRoaXMgYmFzaWMgdHJpdmlhbCB3b3JrIHJlYWxseSBoZWxw
cyB0byBnZXQgdGhpcyB3aG9sZQptZXNzIHVuZGVyIGNvbnRyb2wuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

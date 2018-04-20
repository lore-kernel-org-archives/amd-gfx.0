From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/8] dma-buf: add peer2peer flag
Date: Fri, 20 Apr 2018 03:17:55 -0700
Message-ID: <20180420101755.GA11400@infradead.org>
References: <20180329065753.GD3881@phenom.ffwll.local>
 <8b823458-8bdc-3217-572b-509a28aae742@gmail.com>
 <20180403090909.GN3881@phenom.ffwll.local>
 <20180403170645.GB5935@redhat.com>
 <20180403180832.GZ3881@phenom.ffwll.local>
 <20180416123937.GA9073@infradead.org>
 <CAKMK7uEFVOh-R2_4vs1M22_wDau0oNTgmCcTWDE+ScxL=92+2g@mail.gmail.com>
 <20180419081657.GA16735@infradead.org>
 <20180420071312.GF31310@phenom.ffwll.local>
 <3e17afc5-7d6c-5795-07bd-f23e34cf8d4b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <3e17afc5-7d6c-5795-07bd-f23e34cf8d4b@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, Jerome Glisse <jglisse@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBBcHIgMjAsIDIwMTggYXQgMTA6NTg6NTBBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiA+IFllcyB0aGVyZSdzIGEgYml0IGEgbGF5ZXJpbmcgdmlvbGF0aW9uIGluc29m
YXIgdGhhdCBkcml2ZXJzIHJlYWxseQo+ID4gc2hvdWxkbid0IGVhY2ggaGF2ZSB0aGVpciBvd24g
Y29weSBvZiAiaG93IGRvIEkgY29udmVydCBhIHBpZWNlIG9mIGRtYQo+ID4gbWVtb3J5IGludG8g
IGRtYS1idWYiLCBidXQgdGhhdCBkb2Vzbid0IHJlbmRlciB0aGUgaW50ZXJmYWNlIGEgYmFkIGlk
ZWEuCj4gCj4gQ29tcGxldGVseSBhZ3JlZSBvbiB0aGF0Lgo+IAo+IFdoYXQgd2UgbmVlZCBpcyBh
biBzZ19hbGxvY190YWJsZV9mcm9tX3Jlc291cmNlcyhkZXYsIHJlc291cmNlcywKPiBudW1fcmVz
b3VyY2VzKSB3aGljaCBkb2VzIHRoZSBoYW5kbGluZyBjb21tb24gdG8gYWxsIGRyaXZlcnMuCgpB
IHN0cnVjdHVyZSB0aGF0IGNvbnRhaW5zCgp7cGFnZSxvZmZzZXQsbGVufSArIHtkbWFfYWRkcitk
bWFfbGVufQoKaXMgbm90IGEgZ29vZCBjb250YWluZXIgZm9yIHN0b3JpbmcKCnt2aXJ0IGFkZHIs
IGRtYV9hZGRyLCBsZW59CgpubyBtYXR0ZXIgd2hhdCBpbnRlcmZhY2UgeW91IGJ1aWxkIGFyb25k
IGl0LiAgQW5kIHRoYXQgaXMgZGlzY291bnRpbmcKYWxsIHRoZSBwcm9ibGVtcyBhcm91bmQgbWFw
cGluZyBjb2hlcmVudCBhbGxvY2F0aW9ucyBmb3Igb3RoZXIgZGV2aWNlcywKb3IgdGhlIGlvbW11
IG1lcmdpbmcgcHJvYmxlbSB3ZSBhcmUgaGF2aW5nIGFub3RoZXIgdGhyZWFkIG9uLgoKU28gbGV0
J3MgY29tZSB1cCB3aXRoIGEgYmV0dGVyIGhpZ2ggbGV2ZWwgaW50ZXJmYWNlIGZpcnN0LCBhbmQg
dGhlbgp3b3JydHkgYWJvdXQgaG93IHRvIGltcGxlbWVudCBpdCBpbiB0aGUgbG93LWxldmVsIGRt
YS1tYXBwaW5nIGludGVyZmFjZQpzZWNvbmQuICBFc3BlY2lhbGx5IGdpdmVuIHRoYXQgbXkgY29u
c29saWRhdGlvbiBvZiB0aGUgZG1hX21hcF9vcHMKaW1wbGVtZW50YXRpb24gaXMgaW4gZnVsbCBz
dHJlYW0gYW5kIHRoZXJlIHNob3Vkbid0IGJlIGFsbCB0aGF0IG1hbnkKdG8gYm90aGVyIHdpdGgu
CgpTbyBmaXJzdCBxdWVzdGlvbjogIERvIHlvdSBhY3R1YWxseSBjYXJlIGFib3V0IGhhdmluZyBt
dWx0aXBsZQpwYWlycyBvZiB0aGUgYWJvdmUsIG9yIGluc3RlYWQgb2YgYWxsIGNodW5rcyBqdXN0
IGRlYWwgd2l0aCBhIHNpbmdsZQpvZiB0aGUgYWJvdmU/ICBJbiB0aGF0IGNhc2Ugd2UgcmVhbGx5
IHNob3VsZCBub3QgbmVlZCB0aGF0IG1hbnkKbmV3IGludGVyZmFjZXMgYXMgZG1hX21hcF9yZXNv
dXJjZSB3aWxsIGJlIGFsbCB5b3UgbmVlZCBhbnl3YXkuCgo+IAo+IENocmlzdGlhbi4KPiAKPiA+
IC1EYW5pZWwKPiAKLS0tZW5kIHF1b3RlZCB0ZXh0LS0tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
